import { Plugin, ESObject, CloakPlugins } from "@wisdomgarden/cloak";

export interface JpushPlugin extends Plugin {
  addEventListener(event: string, handler: (event: ESObject) => void): string;
  init(): Promise<boolean>;
  setDebugMode(isDebug: boolean): void;
  setBadge(badgeNumber: number): void;
  getRegistrationId(): string;
  resumePush(): void;
  stopPush(): void;
  isPushStopped(): boolean;
  setAlias(sequence: number, alias: string): Promise<ESObject>;
  getAlias(sequence: number): Promise<ESObject>;
  deleteAlias(sequence: number): Promise<ESObject>;
  addTags(sequence: number, tags: string[]): Promise<ESObject>;
  cleanTags(sequence: number): Promise<ESObject>;
  getTags(sequence: number, curr?: number): Promise<ESObject>;
  checkTagBindState(sequence: number, tag: string): Promise<ESObject>;
  setProcessTimeout(timeout: number): void;
}

export const register: () => void;
export const Jpush: JpushPlugin;

declare module "@wisdomgarden/cloak" {
  export interface CloakPlugins {
    Jpush: JpushPlugin;
  }
}
