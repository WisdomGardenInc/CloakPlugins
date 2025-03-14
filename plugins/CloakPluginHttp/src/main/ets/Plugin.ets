import { CloakPlugin, PluginMethod } from '@wisdomgarden/cloak';
import { http } from '@kit.NetworkKit';
import { BusinessError } from '@ohos.base';
import BuildProfile from '../../../BuildProfile';


interface IRequestOptions {
  method: 'get' | 'post' | 'put' | 'head' | 'delete' | 'options';
  data?: ESObject;
  params?: Map<string, string | number>;
  serializer?: 'json' | 'urlencoded' | 'utf8' | 'multipart';
  timeout?: number;
  headers?: ESObject;
  filePath?: string | string[];
  name?: string | string[];
  responseType?: 'text' | 'arraybuffer' | 'blob' | 'json';
}

interface IResponse {
  status: number;
  headers: ESObject;
  url: string;
  data?: ESObject;
  error?: string;
}

interface IDefaultHeaders {
  'Content-Type': string;
  'Accept': string;
}

const try2Json = (text: ESObject): ESObject => {
  try {
    return JSON.parse(text);
  } catch (e) {
    return text;
  }
}

export default class Http extends CloakPlugin {
  protected _name = "Http";
  protected _version = BuildProfile.HAR_VERSION;

  @PluginMethod()
  async sendRequest(url: string, options?: IRequestOptions) {
    const httpRequest = http.createHttp();


    const headers: IDefaultHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };


    if (options?.headers) {
      for (const key of Object.keys(options?.headers)) {
        Reflect.set(headers, key, Reflect.get(options.headers, key));
      }
    }

    // fuck ArcTS !!!
    const expectJson = Reflect.get(headers, 'Accept')?.includes('application/json')

    const response: IResponse = {
      status: 0,
      headers: {},
      url: 'string',
    }

    const result = new Promise<IResponse>(async (resolve, reject) => {
      try {
        const result = await httpRequest.request(
          url,
          {
            method: options?.method ? options.method.toUpperCase() as http.RequestMethod : http.RequestMethod.GET,
            header: headers,
            extraData: options?.data,
            // expectDataType: http.HttpDataType.STRING,
            usingCache: false,
            priority: 1,
            connectTimeout: 60000, // ms
            readTimeout: 60000, // ms
            // usingProtocol: http.HttpProtocol.HTTP1_1,
            usingProxy: false,
          },
        );

        response.status = result.responseCode;
        response.headers = result.header;
        response.url = url;

        if (expectJson) {
          response.data = try2Json(result.result);
        } else {
          response.data = result.result;
        }

        if (response.status >= 400) {
          reject(response)
        } else {
          resolve(response)
        }
      } catch (err) {
        const error = err as BusinessError;
        response.status = 0;
        response.headers = {};
        response.url = url;
        response.data = error;

        reject(response)
      } finally {
        httpRequest.destroy();
      }

    });
    return result;
  }
}