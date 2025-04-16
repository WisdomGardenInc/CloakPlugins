[中文版](./README.md) | [**English Version**](./README-EN.md)

# Cloak Plugins

This project is a collection of [Cloak](https://github.com/WisdomGardenInc/Cloak) framework plugins developed by the official [WisdomGarden](https://tronclass.com.cn/) team.

Each plugin also has a corresponding `npm` package with the same name, making it convenient for `TypeScript` and frontend **extensions**.

## Plugin List

- **[CloakPluginPermission](./plugins/CloakPluginPermission/README-EN.md)**
  
  Used to check and request HarmonyOS permissions.

  ```bash
  ohpm i @wisdomgarden/cloak-plugin-permission
  npm i @wisdomgarden/cloak-plugin-permission # optional
  ```

- **[CloakPluginHttp](./plugins/CloakPluginHttp/README-EN.md)**
  
  Used to make Native HTTP requests within Cloak applications.

  ```bash
  ohpm i @wisdomgarden/cloak-plugin-http
  npm i @wisdomgarden/cloak-plugin-http # optional
  ```

- **[CloakPluginInAppBrowser](./plugins/CloakPluginInAppBrowser/README-EN.md)**
  
  Used to open internal browsers in Cloak applications and perform operations.

  ```bash
  ohpm i @wisdomgarden/cloak-plugin-inappbrowser
  npm i @wisdomgarden/cloak-plugin-inappbrowser # optional
  ```

- **[CloakPluginOpenNativeSettings](https://github.com/WisdomGardenInc/CloakPlugins/blob/master/plugins/CloakPluginOpenNativeSettings/README-EN.md)**

  used for opening native settings pages within Cloak applications

  ```bash
  ohpm i @wisdomgarden/cloak-plugin-open-native-settings
  npm i @wisdomgarden/cloak-plugin-open-native-settings # optional
  ```

- **[CloakPluginJpush](https://github.com/WisdomGardenInc/CloakPlugins/blob/master/plugins/CloakPluginJpush/README-EN.md)**

  Used to integrate JPush in Cloak applications to receive notifications.

  ```bash
  ohpm install @wisdomgarden/cloak-plugin-jpush
  npm install @wisdomgarden/cloak-plugin-jpush # optional
  ```

***✨✨✨ More plugins are coming soon, stay tuned. ✨✨✨***

---

# About **Cloak**

**Cloak** is a lightweight hybrid development framework for **HarmonyOS**, inspired by [Cordova](https://cordova.apache.org/) and [Capacitor](https://capacitorjs.com/), but with **simpler implementation** and **better performance**.

Enables rapid conversion of web applications to native HarmonyOS apps with plugin-based native API access.

---

## Core Features

- **Quick Packaging**
  Compile H5/web apps into HarmonyOS applications within minutes

- **Native API Access**
  Extend functionality through HarmonyOS native plugins

- **Optimized WebView**
  High-performance WebView container with hardware acceleration

- **Plugin Development**
  Easily create HarmonyOS native plugins using TypeScript/ArkTS

For more information about the Cloak framework, please visit: https://github.com/WisdomGardenInc/Cloak