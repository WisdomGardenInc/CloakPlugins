import { Plugin } from "@wisdomgarden/cloak";
import { GrantStatus, SwitchType } from "./@ohos.abilityAccessCtrl";
import { Permissions } from "./permissions";

interface CapacitorPermissionResult {
  state: "granted" | "denied" | "prompt" | "unavailable";
}

export interface PermissionPlugin extends Plugin {
  query: (permissions: Permissions | Permissions[]) => Promise<Record<Permissions, [GrantStatus, boolean]>>;
  request: (permissions: Permissions | Permissions[]) => Promise<Record<Permissions, [GrantStatus, boolean]>>;
  requestGlobalSwitch: (type: SwitchType) => Promise<boolean>;
  queryNotificationPermission: () => Promise<boolean>;
  requestNotificationPermission: () => Promise<boolean>;
  queryLikeCapacitor: (payload: { name: string }) => Promise<CapacitorPermissionResult>;
  requestLikeCapacitor: (payload: { name: string }) => Promise<CapacitorPermissionResult>;
}

export { GrantStatus, Permissions };

export const register: () => void;
export const Permission: PermissionPlugin;

declare module "@wisdomgarden/cloak" {
  export interface CloakPlugins {
    Permission: PermissionPlugin;
  }
}
