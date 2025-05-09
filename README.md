[**English Version**](./README-EN.md) | [中文版](./README.md)

# Cloak Plugins

这个项目是 [WisdomGarden](https://tronclass.com.cn/) 官方团队开发的 [Cloak](https://github.com/WisdomGardenInc/Cloak) 框架插件集合。

每个插件还有配套的同名 `npm` 包，方便 `Typescript` 和前端**扩展**。

## 插件列表

- **[CloakPluginPermission](./plugins/CloakPluginPermission/README.md)**
  
  用于检查、请求 HarmonyOS 权限。
  
  ```bash
  ohpm i @wisdomgarden/cloak-plugin-permission
  npm i @wisdomgarden/cloak-plugin-permission # optional
  ```

- **[CloakPluginHttp](./plugins/CloakPluginHttp/README.md)**
  
  用于在 Cloak 应用中进行 Native HTTP 请求。

  ```bash
  ohpm i @wisdomgarden/cloak-plugin-http
  npm i @wisdomgarden/cloak-plugin-http # optional
  ```

- **[CloakPluginInAppBrowser](./plugins/CloakPluginInAppBrowser/README.md)**
  
  用于在 Cloak 应用中打再开内部浏览器，执行操作。

  ```bash
  ohpm i @wisdomgarden/cloak-plugin-inappbrowser
  npm i @wisdomgarden/cloak-plugin-inappbrowser # optional
  ```

- **[CloakPluginOpenNativeSettings](https://github.com/WisdomGardenInc/CloakPlugins/blob/master/plugins/CloakPluginOpenNativeSettings/README.md)**

  用于在 Cloak 应用中打开原生设置页面。

  ```bash
  ohpm i @wisdomgarden/cloak-plugin-open-native-settings
  npm i @wisdomgarden/cloak-plugin-open-native-settings # optional
  ```

- **[CloakPluginJpush](https://github.com/WisdomGardenInc/CloakPlugins/blob/master/plugins/CloakPluginJpush/README.md)**

  用于在 Cloak 应用中集成极光推送，实现消息推送功能。

  ```bash
  ohpm install @wisdomgarden/cloak-plugin-jpush
  npm install @wisdomgarden/cloak-plugin-jpush # optional
  ```

- **[CloakPluginCodeScanner](https://github.com/WisdomGardenInc/CloakPlugins/blob/master/plugins/CloakPluginCodeScanner/README.md)**

  用于在 Cloak 应用中进行二维码扫描。

  ```bash
  ohpm install @wisdomgarden/cloak-plugin-code-scanner
  npm install @wisdomgarden/cloak-plugin-code-scanner # optional
  ```

***✨✨✨ 更多插件即将推出，敬请期待。 ✨✨✨***

---

# 关于 **Cloak**

**Cloak** 是专为 **HarmonyOS** 设计的混合开发框架，类似 [Cordova](https://cordova.apache.org/) 和 [Capacitor](https://capacitorjs.com/)，但具备 **更轻量**、**更高性能** 的特性。

该框架可将 Web 应用快速转换为原生应用，同时通过插件机制访问 HarmonyOS 原生能力。

---

## 核心特性

- **快速打包**：将 H5 应用快速编译为 HarmonyOS 应用。
- **原生能力访问**：通过插件机制调用原生接口。
- **WebView 支持**：提供高性能 WebView 容器，确保 H5 应用流畅运行。
- **插件开发**：支持开发者自定义插件以扩展原生功能。

更多关于 Cloak 框架信息，请查看: https://github.com/WisdomGardenInc/Cloak