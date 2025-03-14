import { Plugin, ESObject, CloakPlugins } from "@wisdomgarden/cloak";

interface RequestOptions {
  method: 'get' | 'post' | 'put' | 'head' | 'delete' | 'options';
  data?: ESObject;
  params?: { [key: string]: string | number };
  timeout?: number;
  headers?: { [key: string]: string };
}

interface HTTPResponse {
  status: number;
  headers: { [key: string]: string };
  url: string;
  data?: ESObject;
  error?: ESObject;
}


export interface HttpPlugin extends Plugin {
  sendRequest(url: string, options?: RequestOptions): Promise<HTTPResponse>;
}

declare module "@wisdomgarden/cloak" {
  export interface CloakPlugins {
    Http: HttpPlugin;
  }
}
