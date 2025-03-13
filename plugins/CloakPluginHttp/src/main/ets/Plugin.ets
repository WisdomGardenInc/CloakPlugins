import { CloakPlugin, PluginMethod } from '@wisdomgarden/cloak';

export default class Http extends CloakPlugin {
  protected _name = "Http";
  protected _version = "1.0.0";

  @PluginMethod()
  async sendRequest(url: string) {
    
    return;
  }
}