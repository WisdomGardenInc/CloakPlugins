[中文版](./README.md) | [**English Version**](./README-EN.md)

# CloakPluginHttp

CloakPluginHttp is a plugin for the Cloak framework, used for making HTTP requests within Cloak applications.

## Usage

### Prerequisites

> Install the Cloak framework `@wisdomgarden/cloak`
>
> For more details, refer to [@wisdomgarden/cloak](https://ohpm.openharmony.cn/#/cn/detail/@wisdomgarden%2Fcloak)

1. Install the CloakPluginHttp plugin
   ```bash
   ohpm install @wisdomgarden/cloak-plugin-http
   ```

2. Declare internet access permissions in your project's `entry/src/main/module.json5`.
   
   [Official Documentation](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/declare-permissions-V5#%E5%9C%A8%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6%E4%B8%AD%E5%A3%B0%E6%98%8E%E6%9D%83%E9%99%90)
   
   Example:
   ```json5
   "requestPermissions": [
    // ...
    {
      "name": "ohos.permission.INTERNET",
      "reason": "$string:permission_internet_reason",
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

### Example Code

#### Sending GET Request
```javascript
const httpGet = async () => {
  const url = "https://api.restful-api.dev/objects";
  const response = await Cloak.plugins.Http.sendRequest(url);
  alert(JSON.stringify(response.data, null , 2));
};
```

#### Sending POST Request
```javascript
const httpPost = async () => {
  const url = "https://api.restful-api.dev/objects";
  const response = await Cloak.plugins.Http.sendRequest(url, {
    method: "post",
    headers: {
      "Content-Type": "application/json",
    },
    data: {
      username: "account",
      password: "password",
    },
  });
  alert(JSON.stringify(response.data, null , 2));
};
```

### Core Interface

#### Sending HTTP Request
```typescript
export interface HttpPlugin extends Plugin {
  sendRequest(url: string, options?: RequestOptions): Promise<HTTPResponse>;
}
```

## Interface Type Definitions

### Request Options
```typescript
interface RequestOptions {
  method?: string;
  headers?: { [key: string]: string };
  data?: ESObject;
}
```

### HTTP Response
```typescript
interface HTTPResponse {
  status: number;
  headers: { [key: string]: string };
  url: string;
  data?: ESObject;
  error?: ESObject;
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