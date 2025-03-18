import { CloakPlugin, PluginMethod } from '@wisdomgarden/cloak';
import { BusinessError } from '@ohos.base';
import BuildProfile from '../../../BuildProfile';
import { common, Want } from '@kit.AbilityKit';


type ISettingType = "application"

export default class NativeSettings extends CloakPlugin {
  protected _name = "NativeSettings";
  protected _version = BuildProfile.HAR_VERSION;

  private async openAbility(want: Want) {
    try {
      await (getContext() as common.UIAbilityContext).startAbility(want)

      return true;
    } catch (err) {
      const error = (err as BusinessError);
      console.error(`Failed to startAbility. Code: ${error.code}, message: ${error.message}`);
      return false;
    }
  }

  private getApplicationSettingWant(): Want {
    const packageName = getContext().applicationInfo.name;
    return {
      bundleName: 'com.huawei.hmos.settings',
      abilityName: 'com.huawei.hmos.settings.MainAbility',
      uri: 'application_info_entry',
      parameters: {
        pushParams: packageName
      }
    }
  }


  @PluginMethod()
  async open(settingType?: ISettingType) {
    let want: Want;
    switch (settingType) {
      default:
        want = this.getApplicationSettingWant();
        break;
    }

    this.openAbility(want)
  }
}