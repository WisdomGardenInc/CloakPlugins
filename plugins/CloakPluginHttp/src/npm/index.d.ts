import { Plugin, ESObject, CloakPlugins } from "@wisdomgarden/cloak";


export interface HttpPlugin extends Plugin {

}

declare module "@wisdomgarden/cloak" {
  export interface CloakPlugins {
    Http: HttpPlugin;
  }
}
