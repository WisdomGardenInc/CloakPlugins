import { Plugin, CloakPlugins } from "@wisdomgarden/cloak";

type ISettingType = "application"


export interface NativeSettingsPlugin extends Plugin {
  open(settingType?: ISettingType): void;
}

export const register: () => void;
export const NativeSettings: NativeSettingsPlugin;

declare module "@wisdomgarden/cloak" {
  export interface CloakPlugins {
    NativeSettings: NativeSettingsPlugin;
  }
}
