import { Cloak, CloakPlugin, PluginMethod } from '@wisdomgarden/cloak';
import { NotificationCallback } from './NotificationCallback';
import { JAliasMessage, JMessage, JPushInterface } from '@jg/push';
import BuildProfile from '../../../BuildProfile';
import pushCommon from '@hms.core.push.pushCommon';
import { pushService } from '@kit.PushKit';
import logger, { PLUGIN_NAME } from './config';
import { Want } from '@kit.AbilityKit';
import { emitter } from '@kit.BasicServicesKit';

interface IJpushMetadata {
  channel: string,
  appKey: string,
  isDebug: boolean,
  want?: Want | null
}

interface IEntryMessage {
  eventType: string;
  message: JMessage;
}

interface IJpushProcessTimeout {
  code: number,
  message: string
};

const JpushProcessTimeoutData: IJpushProcessTimeout = { code: 9000, message: "timeout" };

export default class Jpush extends CloakPlugin {
  protected _name = PLUGIN_NAME;
  protected _version = BuildProfile.HAR_VERSION;
  private entryMessage: IEntryMessage | null = null;
  private processTimeout = 30000;

  constructor(data: IJpushMetadata) {
    super();
    JPushInterface.setAppKey(data.appKey);
    JPushInterface.setChannel(data.channel);
    JPushInterface.setDebug(data.isDebug)

    if (data.want) {
      this.setClickWant(data.want);
    }

    emitter.on('JpushEvent:onClickMessage', (event: emitter.EventData) => {
      this._sendEvent('jpush.openNotification', event.data as JMessage);
    })

    emitter.on('JpushEvent:onCustomMessage', (event: emitter.EventData) => {
      this._sendEvent('jpush.receiveMessage', event.data as JMessage);
    })
  }

  private async setClickWant(want: Want) {
    let j: JMessage | undefined = await JPushInterface.setClickWant(want);
    logger.info('%{public}s', 'setClickWant: ' + JSON.stringify(j));
  }

  private async processCustomMessageBackgroundData(data: pushCommon.PushPayload) {
    await JPushInterface.customMessageBackgroundData(data)
  }


  // events: jpush.openNotification, jpush.receiveMessage
  protected _sendEvent(eventType: string, payload: JMessage) {
    logger.debug(`Jpush,  _sendEvent: ${eventType}, isAttached:${this.isAttached}`);
    // After being attached, it is possible that `addEventListener` has not been called yet, so special handling is applied here.
    if (this.isAttached && this.hasEvent(eventType)) {
      super._sendEvent(eventType, payload)
    } else {
      this.entryMessage = {
        eventType, message: payload
      };
    }
  }


  @PluginMethod()
  public addEventListener(event: string, handler: (event: ESObject) => void) {
    logger.info(`Jpush addEventListener: ${event}, entryMessage: ${this.entryMessage}`);
    const eventId = super.addEventListener(event, handler);

    if (this.entryMessage?.eventType === event) {
      this._sendEvent(this.entryMessage.eventType, this.entryMessage.message);
      this.entryMessage = null;
    }

    return eventId;
  }

  protected _onAttach() {
    logger.info(`Jpush on attached`);
  }


  @PluginMethod()
  async init() {
    // https://docs.jiguang.cn/jpush/practice/tag_and_alias#%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9
    // init 后直接 set 操作有极大可能导致失败，可能会在回调里拿到 6022,6002 等，测试的时候可以做个 7、8 秒的延时，正式业务里一般配合用户注册使用，延时基本上够用
    return new Promise<boolean>((resolve) => {
      setTimeout(async () => {
        let result = true;

        try {
          pushService.receiveMessage('BACKGROUND', Cloak.getAbility(), this.processCustomMessageBackgroundData);
        } catch (error) {
          result = false;
          logger.error(`Jpush listen BACKGROUND message error: ${error}`);
        }

        const notificationCallback = new NotificationCallback(CloakPlugin.applicationContext);
        JPushInterface.setCallBackMsg(notificationCallback);


        try {
          await JPushInterface.init(Cloak.getAbility().context)

        } catch (error) {
          result = false;
          logger.error(`Jpush init error: ${error}`);
        }

        if (JPushInterface.isPushStopped()) {
          JPushInterface.resumePush();
        }

        resolve(result);
      }, 1000);

    })

  }


  @PluginMethod()
  setDebugMode(isDebug: boolean) {
    // call before init
    JPushInterface.setDebug(isDebug)
  }

  @PluginMethod()
  setBadge(badgeNumber: number) {
    JPushInterface.setBadgeNumber(badgeNumber)
  }

  @PluginMethod()
  getRegistrationId() {
    return JPushInterface.getRegistrationId();
  }

  @PluginMethod()
  resumePush() {
    return JPushInterface.resumePush()
  }


  @PluginMethod()
  stopPush() {
    return JPushInterface.stopPush()
  }

  @PluginMethod()
  isPushStopped() {
    return JPushInterface.isPushStopped()
  }


  private async processJpushOperate(event: string, process: Function) {
    let timerId = 0;
    let callback: Callback<emitter.EventData> | null = null;

    const businessPromise = new Promise<JAliasMessage>((resolve) => {

      callback = (event: emitter.EventData) => {
        if (event.data) {
          resolve(event.data);
        }
      }

      emitter.once(event, callback);
      process();
    })

    const timeoutPromise = new Promise <IJpushProcessTimeout>((_, reject) => {
      timerId = setTimeout(() => {
        reject(JpushProcessTimeoutData);
      }, this.processTimeout);
    })

    const result = await Promise.race([businessPromise, timeoutPromise]).finally(() => {
      if (callback) {
        emitter.off(event, callback);
      }

      if (timerId) {
        clearTimeout(timerId);
      }

    })

    return result;
  }


  @PluginMethod()
  async setAlias(sequence: number, alias: string) {
    return await this.processJpushOperate('JpushEvent:onAliasOperatorResult', () => {
      JPushInterface.setAlias(sequence, alias)
    });
  }

  @PluginMethod()
  async getAlias(sequence: number) {
    return await this.processJpushOperate('JpushEvent:onAliasOperatorResult', () => {
      JPushInterface.getAlias(sequence)
    });
  }

  @PluginMethod()
  async deleteAlias(sequence: number) {
    return await this.processJpushOperate('JpushEvent:onAliasOperatorResult', () => {
      JPushInterface.deleteAlias(sequence)
    });
  }


  @PluginMethod()
  async addTags(sequence: number, tags: string[]) {
    return await this.processJpushOperate('JpushEvent:onTagOperatorResult', () => {
      JPushInterface.addTags(sequence, tags)
    });
  }

  @PluginMethod()
  async cleanTags(sequence: number) {
    return await this.processJpushOperate('JpushEvent:onTagOperatorResult', () => {
      JPushInterface.cleanTags(sequence)
    });
  }

  @PluginMethod()
  async getTags(sequence: number, curr: number = 1) {
    return await this.processJpushOperate('JpushEvent:onTagOperatorResult', () => {
      return JPushInterface.getTags(sequence, curr)
    });
  }

  @PluginMethod()
  checkTagBindState(sequence: number, tag: string) {
    return JPushInterface.checkTagBindState(sequence, tag)
  }

  @PluginMethod()
  setProcessTimeout(timeout: number) {
    this.processTimeout = timeout;
  }
}