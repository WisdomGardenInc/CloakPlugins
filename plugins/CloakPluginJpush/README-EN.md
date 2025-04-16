[中文版](./README.md) | [**English Version**](./README-EN.md)

# CloakPluginJpush

CloakPluginJpush is a plugin for the Cloak framework, designed to integrate JPush notification service into Cloak applications.

This plugin is built on top of the official JPush [@jg/push](https://ohpm.openharmony.cn/#/cn/detail/@jg%2Fpush)

## Usage

### Prerequisites

> Install Cloak framework `@wisdomgarden/cloak`
>
> For more details, refer to [@wisdomgarden/cloak](https://ohpm.openharmony.cn/#/cn/detail/@wisdomgarden%2Fcloak)

1. Install CloakPluginJpush plugin
   ```bash
   ohpm install @wisdomgarden/cloak-plugin-jpush
   npm install @wisdomgarden/cloak-plugin-jpush # optional
   ```

2. Platform Configuration
   Refer to JPush documentation: [Configure HMOS platform information, signing, and JPush platform settings](https://docs.jiguang.cn/jpush/client/HarmonyOS/hmos_guide#%E9%9B%86%E6%88%90%E6%96%B9%E5%BC%8F)
   
3. Import the plugin in `entry/src/main/ets/entryability/EntryAbility.ets`
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

4. You can now use the plugin in your H5 code
    ```javascript
    // Example usage
    await Cloak.plugins.Jpush.init();
    await Cloak.plugins.Jpush.setAlias(1, 'user123');
    ``` 

5. If you're using TypeScript, install the NPM package for type support   
   ```bash
   npm install @wisdomgarden/cloak-plugin-jpush
   ```

### Example Code

#### Initialize and Listen to Events

```javascript
// Initialize plugin
await Cloak.plugins.Jpush.init();

// Set debug mode
Cloak.plugins.Jpush.setDebugMode(true);

// Listen for notification click events
Cloak.plugins.Jpush.addEventListener('jpush.openNotification', (event) => {
  console.log('User clicked notification:', event);
});

// Listen for custom message events
Cloak.plugins.Jpush.addEventListener('jpush.receiveMessage', (event) => {
  console.log('Received custom message:', event);
});

// Get registration ID
const registrationId = await Cloak.plugins.Jpush.getRegistrationId();
console.log('Registration ID:', registrationId);
```

#### Tags and Alias Operations

```javascript
// Set alias
const aliasResult = await Cloak.plugins.Jpush.setAlias(1, 'user123');
console.log('Set alias result:', aliasResult);

// Add tags
const tagsResult = await Cloak.plugins.Jpush.addTags(1, ['vip', 'level1']);
console.log('Add tags result:', tagsResult);
```

### Core Interface

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

### Event Types

- `jpush.openNotification`: Triggered when user clicks a notification
- `jpush.receiveMessage`: Triggered when receiving a custom message

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