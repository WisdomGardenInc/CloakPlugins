[**English Version**](./README-EN.md) | [中文版](./README.md)

# CloakPluginJpush

CloakPluginJpush 是 Cloak 框架的插件之一，用于在 Cloak 应用中集成极光推送，实现消息推送功能。

本插件底层使用极光官方的 [@jg/push](https://ohpm.openharmony.cn/#/cn/detail/@jg%2Fpush)

## 使用方法

### 前置条件

> 安装 Cloak 框架 `@wisdomgarden/cloak`
>
> 具体细节参考 [@wisdomgarden/cloak](https://ohpm.openharmony.cn/#/cn/detail/@wisdomgarden%2Fcloak)

1. 安装 CloakPluginJpush 插件
   ```bash
   ohpm install @wisdomgarden/cloak-plugin-jpush
   npm install @wisdomgarden/cloak-plugin-jpush # optional
   ```

2. 平台配置项
   [参考极光文档：配置 hmos平台信息， 配置签署， 配置极光平台信息](https://docs.jiguang.cn/jpush/client/HarmonyOS/hmos_guide#%E9%9B%86%E6%88%90%E6%96%B9%E5%BC%8F)
   
3. 在 `entry/src/main/ets/entryability/EntryAbility.ets` 中引入插件
   ```javascript
   new Cloak(this, [new CloakPluginJpush(
      {
        channel: isDebug ? "Development" : "Production",
        appKey: "xxxxxx",
        isDebug,
        want: jpushMessageWant ? want : null
      }
    )]);
   ```

4. 在 H5 逻辑代码中就可以直接调用该插件
    ```javascript
    // 示例代码
    await Cloak.plugins.Jpush.init();
    await Cloak.plugins.Jpush.setAlias(1, 'user123');
    ```

5. 如果你使用 Typescript，安装 NPM 包获取类型支持   
   ```bash
   npm install @wisdomgarden/cloak-plugin-jpush
   ```

### 示例代码

#### 初始化并监听事件

```javascript
// 初始化插件
await Cloak.plugins.Jpush.init();

// 设置调试模式
Cloak.plugins.Jpush.setDebugMode(true);

// 监听通知点击事件
Cloak.plugins.Jpush.addEventListener('jpush.openNotification', (event) => {
  console.log('用户点击通知:', event);
});

// 监听自定义消息接收事件
Cloak.plugins.Jpush.addEventListener('jpush.receiveMessage', (event) => {
  console.log('收到自定义消息:', event);
});

// 获取注册ID
const registrationId = await Cloak.plugins.Jpush.getRegistrationId();
console.log('注册ID:', registrationId);
```

#### 标签与别名操作

```javascript
// 设置别名
const aliasResult = await Cloak.plugins.Jpush.setAlias(1, 'user123');
console.log('设置别名结果:', aliasResult);

// 添加标签
const tagsResult = await Cloak.plugins.Jpush.addTags(1, ['vip', 'level1']);
console.log('添加标签结果:', tagsResult);
```

### 核心接口

```typescript
interface JpushPlugin extends Plugin {
  addEventListener(event: string, handler: (event: ESObject) => void): string;
  init(): Promise<boolean>;
  setDebugMode(isDebug: boolean): void;
  setBadge(badgeNumber: number): void;
  getRegistrationId(): Promise<string>;
  resumePush(): void;
  stopPush(): void;
  isPushStopped(): boolean;
  setAlias(sequence: number, alias: string): Promise<any>;
  getAlias(sequence: number): Promise<any>;
  deleteAlias(sequence: number): Promise<any>;
  addTags(sequence: number, tags: string[]): Promise<any>;
  cleanTags(sequence: number): Promise<any>;
  getTags(sequence: number, curr?: number): Promise<any>;
  checkTagBindState(sequence: number, tag: string): Promise<any>;
  setProcessTimeout(timeout: number): void;
}
```

### 事件类型

- `jpush.openNotification`: 用户点击通知时触发
- `jpush.receiveMessage`: 收到自定义消息时触发

---

# 关于 **Cloak**

**Cloak** 是专为 **HarmonyOS** 设计的混合开发框架，类似 [Cordova](https://cordova.apache.org/) 和 [Capacitor](https://capacitorjs.com/)，但具备 **更轻量**、**更高性能** 的特性。

该框架可将 Web 应用快速转换为原生应用，同时通过插件机制访问 HarmonyOS 原生能力。


## 核心特性

- **快速打包**：将 H5 应用快速编译为 HarmonyOS 应用。
- **原生能力访问**：通过插件机制调用原生接口。
- **WebView 支持**：提供高性能 WebView 容器，确保 H5 应用流畅运行。
- **插件开发**：支持开发者自定义插件以扩展原生功能。

更多关于 Cloak 框架信息，请查看: https://github.com/WisdomGardenInc/Cloak