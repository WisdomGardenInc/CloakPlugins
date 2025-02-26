[中文版](./README.md) | [**English Version**](./README-EN.md)

# CloakPluginPermission

CloakPluginPermission is one of the plugins of the [Cloak framework](https://github.com/WisdomGardenInc/Cloak), used to check and request HarmonyOS permissions.


## Usage
### Prerequisites
  Install the Cloak framework `@wisdomgarden/cloak`

  For more details, refer to [@wisdomgarden/cloak](https://ohpm.openharmony.cn/#/cn/detail/@wisdomgarden%2Fcloak)

1. Install the CloakPluginPermission plugin
  ```bash
  ohpm install @wisdomgarden/cloak-plugin-permission
  ```

2. Declare the required permissions in the project entry/src/main/module.json5.
  
  [Official Documentation](https://developer.huawei.com/consumer/en/doc/harmonyos-guides-V5/declare-permissions-V5#%E5%9C%A8%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6%E4%B8%AD%E5%A3%B0%E6%98%8E%E6%9D%83%E9%99%90)
  
  [Permission List](https://developer.huawei.com/consumer/en/doc/harmonyos-guides-V5/permissions-for-all-V5#user_grant%E7%94%A8%E6%88%B7%E6%8E%88%E6%9D%83%E6%9D%83%E9%99%90%E5%88%97%E8%A1%A8)
  
  Example:
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

3. [Optional] Add/override the permission request description internationalization file in the project entry/src/main/resources/base/element/string.json.
   Cloak has already built-in some permission request description internationalization [files](https://github.com/WisdomGardenInc/Cloak/blob/master/framework/src/main/resources/base/element/string.json).

  [Official Documentation](https://developer.huawei.com/consumer/en/doc/harmonyos-guides-V5/resource-categories-and-access-V5)
  
  Example:
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

4. You can directly call it in the H5 logic code.
  
  Example:
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