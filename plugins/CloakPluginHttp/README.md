[**English Version**](./README-EN.md) | [中文版](./README.md)

# CloakPluginNativeHttp

CloakPluginHttp 是 Cloak 框架的插件之一，用于在 Cloak 应用中进行 HTTP 请求。

## 使用方法

### 前置条件


> 安装 Cloak 框架 `@wisdomgarden/cloak`
>
> 具体细节参考 [@wisdomgarden/cloak](https://ohpm.openharmony.cn/#/cn/detail/@wisdomgarden%2Fcloak)

1. 安装 CloakPluginHttp 插件
   ```bash
   ohpm install @wisdomgarden/cloak-plugin-http
   npm install @wisdomgarden/cloak-plugin-http # optional
   ```

2. 在项目 `entry/src/main/module.json5` 中声明网络访问权限。

   [官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/declare-permissions-V5#%E5%9C%A8%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6%E4%B8%AD%E5%A3%B0%E6%98%8E%E6%9D%83%E9%99%90)

   示例：
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

3. 在 H5 逻辑代码中就可以直接调用该插件

4. 如果你使用 Typescript 或者想在前端扩展插件，安装 NPM 包
   ```bash
   npm install @wisdomgarden/cloak-plugin-http
   ```

### 示例代码

#### 发送 GET 请求
```javascript
const httpGet = async () => {
  const url = "https://api.restful-api.dev/objects";
  const response = await Cloak.plugins.Http.sendRequest(url);
  alert(JSON.stringify(response.data, null , 2));
};
```

#### 发送 POST 请求
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

### 核心接口

#### 发送 HTTP 请求
```typescript
export interface HttpPlugin extends Plugin {
  sendRequest(url: string, options?: RequestOptions): Promise<HTTPResponse>;
}
```

## 接口类型定义

### 请求选项
```typescript
interface HTTPResponse {
  status: number;
  headers: { [key: string]: string };
  url: string;
  data?: ESObject;
  error?: ESObject;
}
```

### HTTP 响应

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