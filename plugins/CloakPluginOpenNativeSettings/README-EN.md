[中文版](./README.md) | [**English Version**](./README-EN.md)

# CloakPluginOpenNativeSettings

CloakPluginOpenNativeSettings is a plugin for the Cloak framework, used for opening native settings pages within Cloak applications.

## Usage

### Prerequisites

> Install the Cloak framework `@wisdomgarden/cloak`
>
> For more details, refer to [@wisdomgarden/cloak](https://ohpm.openharmony.cn/#/cn/detail/@wisdomgarden%2Fcloak)

1. Install the CloakPluginOpenNativeSettings plugin
   ```bash
   ohpm install @wisdomgarden/cloak-plugin-open-native-settings
   ```

2. You can now directly call the plugin in your H5 logic code.

### Example Code

#### Open Application Settings Page
```javascript
const openSettings = async () => {
  await Cloak.plugins.NativeSettings.open("application");
};
```

### Core Interface

#### Open Settings Page
```typescript
export interface NativeSettingsPlugin extends Plugin {
  open(settingType?: ISettingType): void;
}
```

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