import { webview } from '@kit.ArkWeb';
import { ICreateBrowserOptions, IWebviewHooks } from './types';


interface InAppWebviewOptionsData {
  webviewController: webview.WebviewController,
  url: string,
  closeDialog: Function,
  webviewHooks: IWebviewHooks,
  createBrowserOptions: ICreateBrowserOptions,
  safeAreaTop: number,
  safeAreaBottom: number,
}


export class InAppWebviewOptions {
  private _webviewController: webview.WebviewController;
  private _url: string;
  private _closeDialog: Function;
  private _webviewHooks: IWebviewHooks;
  private _createBrowserOptions: ICreateBrowserOptions;
  private _safeAreaTop: number;
  private _safeAreaBottom: number;

  constructor(options: InAppWebviewOptionsData) {
    this._webviewController = options.webviewController;
    this._url = options.url;
    this._closeDialog = options.closeDialog;
    this._webviewHooks = options.webviewHooks;
    this._createBrowserOptions = options.createBrowserOptions;
    this._safeAreaTop = options.safeAreaTop;
    this._safeAreaBottom = options.safeAreaBottom;
  }

  public get webviewController(): webview.WebviewController {
    return this._webviewController;
  }

  public get url(): string {
    return this._url;
  }

  public get closeDialog(): Function {
    return this._closeDialog;
  }

  public get webviewHooks(): IWebviewHooks {
    return this._webviewHooks;
  }

  public get createBrowserOptions(): ICreateBrowserOptions {
    return this._createBrowserOptions;
  }

  public get safeAreaTop(): number {
    return this._safeAreaTop;
  }

  public get safeAreaBottom(): number {
    return this._safeAreaBottom;
  }
}


// https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V13/ts-basic-components-web-V13
// https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/js-apis-webview-V5
@Builder
export function InAppWebview(options: InAppWebviewOptions) {
  Flex({
    direction: FlexDirection.Column,
    wrap: FlexWrap.NoWrap,
    justifyContent: FlexAlign.Start,
    alignItems: ItemAlign.Start
  }) {
    Web({
      src: options.url,
      controller: options.webviewController,
      incognitoMode: options.createBrowserOptions.clearCache || options.createBrowserOptions.clearSessionCache
    })
      .javaScriptAccess(true)
      .multiWindowAccess(false)
      .allowWindowOpenMethod(false)
      .domStorageAccess(true)
      .fileAccess(true)
      .imageAccess(true)
      .mixedMode(MixedMode.All)
      .onlineImageAccess(true)
      .zoomAccess(true)
      .overviewModeAccess(false)
      .databaseAccess(true)
      .geolocationAccess(true)
      .cacheMode(CacheMode.Default)
      .copyOptions(CopyOptions.LocalDevice)
      .darkMode(WebDarkMode.On)
      .onGeolocationShow(event => {
        event?.geolocation.invoke(event.origin, true, true);
      })
      .onPermissionRequest(event => {
        event?.request.grant(event.request.getAccessibleResource());
      })
      .onPageBegin(options.webviewHooks.onPageBegin)
      .onPageEnd(options.webviewHooks.onPageEnd)
      .onControllerAttached(() => {
        //
      })
      .onAttach(() => {
        //
      })
      .onDetach(() => {
        if (options.createBrowserOptions.clearCache || options.createBrowserOptions.clearSessionCache) {
          options.webviewController.clearHistory();
          options.webviewController.clearClientAuthenticationCache();
          options.webviewController.closeCamera();
          options.webviewController.closeAllMediaPresentations();
          // options.webviewController.removeCache(true); // 清除应用中的资源缓存文件，此方法将会清除同一应用中所有webview的缓存文件。

          webview.WebStorage.deleteAllData(true);
          webview.WebCookieManager.clearAllCookiesSync(true);
          // webview.WebCookieManager.clearSessionCookieSync(); // 所有 webview？
        }
      })
      .flexGrow(1)
      .width('100%')

    if (options.createBrowserOptions.footer) {
      Flex({ justifyContent: FlexAlign.SpaceBetween, wrap: FlexWrap.NoWrap, alignItems: ItemAlign.Start }) {
        Button() {
          Text(options.createBrowserOptions.closeButtonCaption ?? $r('app.string.common_ui_done'))
            .fontSize(18)
            .fontColor(Color.White)
        }
        .backgroundColor(Color.Transparent)
        .padding({ left: 15, right: 15 })
        .onClick(() => {
          options.closeDialog();
        })

        if (!options.createBrowserOptions.hideNavigationButtons) {
          Row() {
            Button() {
              Image($r('app.media.back')).fillColor(Color.White).width(20).height(20)
            }
            // .opacity(options.webviewAttached ?? options.webviewController.accessBackward() ? 1 : 0.5)
            .backgroundColor(Color.Transparent)
            .padding({ left: 15, right: 15 })
            .onClick(() => {
              if (options.webviewController.accessBackward()) {
                options.webviewController.backward()
              }
            })

            Button() {
              Image($r('app.media.forward')).fillColor(Color.White).width(20).height(20)
            }
            // .opacity(options.webviewAttached && options.webviewController.accessForward() ? 1 : 0.5)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              if (options.webviewController.accessForward()) {
                options.webviewController.forward()
              }
            })
            .padding({ left: 15, right: 15 })
            .margin({ left: 10 })
          }
        }
      }
      .height(options.safeAreaBottom + 20)
      .padding({ left: 20, right: 20, top: 5 })
      .width('100%')
      .backgroundColor(options.createBrowserOptions.footerColor ?? Color.Black)
    }
  }
  .padding({ top: options.safeAreaTop })
  .backgroundColor(Color.White)
  .width("100%")
  .height("100%");

}