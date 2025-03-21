[**English Version**](./README-EN.md) | [中文版](./README.md)

# CloakPluginOpenNativeSettings

CloakPluginOpenNativeSettings 是 Cloak 框架的插件之一，用于在 Cloak 应用中打开原生设置页面。

## 使用方法

### 前置条件

> 安装 Cloak 框架 `@wisdomgarden/cloak`
>
> 具体细节参考 [@wisdomgarden/cloak](https://ohpm.openharmony.cn/#/cn/detail/@wisdomgarden%2Fcloak)

1. 安装 CloakPluginOpenNativeSettings 插件
   ```bash
   ohpm install @wisdomgarden/cloak-plugin-open-native-settings
   npm install @wisdomgarden/cloak-plugin-open-native-settings # optional
   ```

2. 在 H5 逻辑代码中就可以直接调用该插件

3. 如果你使用 Typescript 或者想在前端扩展插件，安装 NPM 包
   
   ```bash
   npm install @wisdomgarden/cloak-plugin-open-native-settings
   ```

### 示例代码

#### 打开应用设置页面
```javascript
const openSettings = async () => {
  await Cloak.plugins.NativeSettings.open("application");
};
```

### 核心接口

#### 打开设置页面
```typescript
export interface NativeSettingsPlugin extends Plugin {
  open(settingType?: ISettingType): void;
}
```

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