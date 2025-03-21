[**English Version**](./README-EN.md) | [中文版](./README.md)

# CloakPluginPermission

CloakPluginPermission 是 Cloak 框架的插件之一，用于检查、请求 HarmonyOS 权限。


## 使用方法

**前置条件**

> 安装 Cloak 框架 `@wisdomgarden/cloak`
> 
> 具体细节参考 [@wisdomgarden/cloak](https://ohpm.openharmony.cn/#/cn/detail/@wisdomgarden%2Fcloak)

1. 安装 CloakPluginPermission 插件
   ```bash
   ohpm install @wisdomgarden/cloak-plugin-permission
   npm install @wisdomgarden/cloak-plugin-permission # optional
   ```
2. 在项目 `entry/src/main/module.json5` 中声明所需权限。

   [官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/declare-permissions-V5#%E5%9C%A8%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6%E4%B8%AD%E5%A3%B0%E6%98%8E%E6%9D%83%E9%99%90)
   
   [权限列表](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/permissions-for-all-V5#user_grant%E7%94%A8%E6%88%B7%E6%8E%88%E6%9D%83%E6%9D%83%E9%99%90%E5%88%97%E8%A1%A8)
   
   示例：
   ```json5
   "requestPermissions": [
    // ...
    {
      "name": "ohos.permission.LOCATION",
      "reason": "$string:permission_location_reason",
      "usedScene": {
        "abilities": [
          "EntryAbility"
        ],
        "when": "inuse"
      }
    },
    // ...
   ]
   ```
   
3. [选做]在项目 `entry/src/main/resources/base/element/string.json` 中添加/覆盖权限请求说明国际化文件。 Cloak 已经内置了部分权限请求说明国际化[文件](https://github.com/WisdomGardenInc/Cloak/blob/master/framework/src/main/resources/base/element/string.json)。

   [官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/resource-categories-and-access-V5)
   
   示例：
   ```json
   {
    "string": [
       // ...
       {
          "name": "permission_location_reason",
          "value": "We need access to your location to offer personalized attendance services, making it easier for you to check in wherever you are."
       },
       // ...
    ]
   }
   ```

4. 在 H5 逻辑代码中就可以直接调用
   
   示例：
   ```javascript
   const queryResult = await Cloak.plugins.Permission.query(['ohos.permission.LOCATION', 'ohos.permission.APPROXIMATELY_LOCATION', 'ohos.permission.CAMERA','ohos.permission.MICROPHONE'])
   alert(JSON.stringify(queryResult, null, 2));
   
   // return
   {
    "ohos.permission.APPROXIMATELY_LOCATION": -1,
    "ohos.permission.CAMERA": -1,
    "ohos.permission.LOCATION": -1,
    "ohos.permission.MICROPHONE": -1
   }
   
   const requestResult = await Cloak.plugins.Permission.request(['ohos.permission.LOCATION', 'ohos.permission.APPROXIMATELY_LOCATION', 'ohos.permission.CAMERA','ohos.permission.MICROPHONE'])
   alert(JSON.stringify(requestResult, null, 2)); 
   
   // return
   {
    "ohos.permission.APPROXIMATELY_LOCATION": 0,
    "ohos.permission.CAMERA": 0,
    "ohos.permission.LOCATION": 0,
    "ohos.permission.MICROPHONE": 0
   }
   
   // enum GrantStatus {
   //    PERMISSION_DENIED = -1,
   //    PERMISSION_GRANTED = 0
   // }
   
   const result = await Cloak.plugins.Permission.requestGlobalSwitch(2)
   // return true
   ```

5. 如果你使用 Typescript 或者想在前端扩展插件，安装 NPM 包
   
   ```bash
   npm install @wisdomgarden/cloak-plugin-permission
   ```

   提供 `queryLikeCapacitor`, `requestLikeCapacitor` 方法类似 Capacitor 输入和输出，具体见[index.d.ts](https://github.com/WisdomGardenInc/CloakPlugins/blob/master/plugins/CloakPluginPermission/src/npm/index.d.ts)
   
   ```typescript
   queryLikeCapacitor: (payload: { name: string }) => Promise<CapacitorPermissionResult>;
   requestLikeCapacitor: (payload: { name: string }) => Promise<CapacitorPermissionResult>;
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