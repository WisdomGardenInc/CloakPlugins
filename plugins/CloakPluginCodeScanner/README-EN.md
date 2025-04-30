[中文版](./README.md) | [**English Version**](./README-EN.md)

# CloakPluginCodeScanner

CloakPluginCodeScanner is one of the plugins for the Cloak framework, used for QR code scanning in Cloak applications.

## Usage

### Prerequisites

> Install the Cloak framework `@wisdomgarden/cloak`
>
> For more details, refer to [@wisdomgarden/cloak](https://ohpm.openharmony.cn/#/cn/detail/@wisdomgarden%2Fcloak)

1. Install the CloakPluginCodeScanner plugin
   ```bash
   ohpm install @wisdomgarden/cloak-plugin-code-scanner
   npm install @wisdomgarden/cloak-plugin-code-scanner # optional
   ```

2. Declare camera permissions in your project's `entry/src/main/module.json5`.

   [Official Documentation](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/declare-permissions-V5#%E5%9C%A8%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6%E4%B8%AD%E5%A3%B0%E6%98%8E%E6%9D%83%E9%99%90)

   Example:
   ```json5
   "requestPermissions": [
    // ...
    {
      "name": "ohos.permission.CAMERA",
      "reason": "$string:permission_camera_reason",
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

3. You can now directly call the plugin in your H5 logic code.

4. If you are using TypeScript or want to extend the plugin on the frontend, install the NPM package
   ```bash
   npm install @wisdomgarden/cloak-plugin-code-scanner
   ```

### Example Code

#### Scan QR Code
```javascript
const scanQRCode = async () => {
  const result = await Cloak.plugins.CodeScanner.scan();
  alert(JSON.stringify(result, null, 2));
};
```

### Core Interface

#### Scan QR Code
```typescript
export interface CodeScannerPlugin extends Plugin {
  scan(): Promise<ScanResult>;
}
```

## Interface Type Definitions

### Scan Result
```typescript
export interface ScanResult {
  error?: {
    code: number;
    name: string;
    message: string;
  };
  result?: {
    originalValue: string;
    scanType: ScanType;
  };
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