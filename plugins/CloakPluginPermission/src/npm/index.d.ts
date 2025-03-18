import { Plugin, Cloak, ESObject, CloakPlugins } from "@wisdomgarden/cloak";
import { GrantStatus } from "./@ohos.abilityAccessCtrl";
import { Permissions } from "./permissions";

interface CapacitorPermissionResult {
  state: "granted" | "denied" | "prompt" | "unavailable";
}

export interface PermissionPlugin extends Plugin {
  query: (permissions: Permissions | Permissions[]) => Promise<Record<Permissions, GrantStatus>>;
  request: (permissions: Permissions | Permissions[]) => Promise<Record<Permissions, GrantStatus>>;
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
