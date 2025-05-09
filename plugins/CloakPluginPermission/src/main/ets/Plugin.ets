import { CloakPlugin, PluginMethod } from '@wisdomgarden/cloak';
import { abilityAccessCtrl, bundleManager, common, Permissions } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { notificationManager } from '@kit.NotificationKit';
import BuildProfile from '../../../BuildProfile';

export default class Permission extends CloakPlugin {
  protected _name = "Permission";
  protected _version = BuildProfile.HAR_VERSION;

  private unifyPermissions(permissions: Permissions | Permissions[]): Permissions[] {
    if (typeof permissions === "string") {
      return [permissions]
    }
    return permissions
  }


  private async queryPermission(permission: Permissions, tokenId: number,
    atManager: abilityAccessCtrl.AtManager): Promise<[Permissions, abilityAccessCtrl.GrantStatus]> {

    try {
      const grantStatus = await atManager.checkAccessToken(tokenId, permission);
      return [permission, grantStatus];
    } catch (error) {
      const err: BusinessError = error as BusinessError;
      console.error(`Failed to check access token. Code is ${err.code}, message is ${err.message}`);
      return [permission, abilityAccessCtrl.GrantStatus.PERMISSION_DENIED];
    }

  }

  @PluginMethod()
  async query(_permissions: Permissions | Permissions[]): Promise<Map<Permissions, abilityAccessCtrl.GrantStatus>> {
    const permissions = this.unifyPermissions(_permissions);
    const result = new Map<Permissions, abilityAccessCtrl.GrantStatus>(permissions.map((p) => [p,
      abilityAccessCtrl.GrantStatus.PERMISSION_DENIED]))

    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();


    let tokenId: number = 0;
    try {
      let bundleInfo: bundleManager.BundleInfo =
        await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
      let appInfo: bundleManager.ApplicationInfo = bundleInfo.appInfo;
      tokenId = appInfo.accessTokenId;
    } catch (error) {
      const err: BusinessError = error as BusinessError;
      console.error(`Failed to get bundle info for self. Code is ${err.code}, message is ${err.message}`);
      return result;
    }

    const checkResults = await
    Promise.all(permissions.map(permission => this.queryPermission(permission, tokenId, atManager)))

    checkResults.forEach((checkResult) => result[checkResult[0]] = checkResult[1])

    return result;
  }


  @PluginMethod()
  async request(_permissions: Permissions | Permissions[]): Promise<Map<Permissions, abilityAccessCtrl.GrantStatus>> {

    const permissions = this.unifyPermissions(_permissions);

    const result = new Map<Permissions, abilityAccessCtrl.GrantStatus>(permissions.map((p) => [p,
      abilityAccessCtrl.GrantStatus.PERMISSION_DENIED]))

    let context = getContext(this) as common.UIAbilityContext;
    let atManager = abilityAccessCtrl.createAtManager();


    try {
      const requestResults = await atManager.requestPermissionsFromUser(context, permissions);

      requestResults.permissions.forEach((permission, index) => {
        result[permission] = requestResults.authResults[index];
      })
    } catch (error) {
      const err: BusinessError = error as BusinessError;
      console.error(`Failed to request permissions from user. Code is ${err.code}, message is ${err.message}`);
    }

    return result;
  }

  @PluginMethod()
  async requestGlobalSwitch(type: abilityAccessCtrl.SwitchType): Promise<boolean> {
    const atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    const context: Context = getContext(this) as common.UIAbilityContext;
    let result = false;
    try {
      result = await atManager.requestGlobalSwitch(context, type)
    } catch (err) {
      if ((err as BusinessError).code === 12100013) {
        result = true;
      }
      console.error('data:' + JSON.stringify(err));
    }
    return result;
  }

  @PluginMethod()
  async queryNotificationPermission() {
    const result = await notificationManager.isNotificationEnabled()
    return result;
  }

  @PluginMethod()
  async requestNotificationPermission() {
    let result = await this.queryNotificationPermission();

    if (result) {
      return result;
    }
    let context = getContext(this) as common.UIAbilityContext;
    try {
      await notificationManager.requestEnableNotification(context);
    } catch (e) {
      console.error(`requestNotificationPermission error code ${(e as BusinessError).code}, message: ${(e as BusinessError).message} aaaa`);
    }
    result = await this.queryNotificationPermission();
    return result;
  }
}