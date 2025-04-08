let PluginInstance = null;
const PluginName = "Permission";

const OHOS_USER_GRANT_PERMISSION = [
  "ohos.permission.ACCESS_BLUETOOTH",
  "ohos.permission.MEDIA_LOCATION",
  "ohos.permission.APP_TRACKING_CONSENT",
  "ohos.permission.ACTIVITY_MOTION",
  "ohos.permission.CAMERA",
  "ohos.permission.DISTRIBUTED_DATASYNC",
  "ohos.permission.LOCATION_IN_BACKGROUND",
  "ohos.permission.LOCATION",
  "ohos.permission.APPROXIMATELY_LOCATION",
  "ohos.permission.MICROPHONE",
  "ohos.permission.READ_CALENDAR",
  "ohos.permission.WRITE_CALENDAR",
  "ohos.permission.READ_HEALTH_DATA",
  "ohos.permission.ACCESS_NEARLINK",
  "ohos.permission.READ_WRITE_DOWNLOAD_DIRECTORY",
  "ohos.permission.READ_WRITE_DOCUMENTS_DIRECTORY",
  "ohos.permission.READ_MEDIA",
  "ohos.permission.WRITE_MEDIA",
];

const compatiblePermissionType = (permission) => {
  permission = permissionOHPermissionMap[permission];
  if (!permission) {
    return permission;
  }
  if (!Array.isArray(permission)) {
    if (OHOS_USER_GRANT_PERMISSION.includes(permission)) {
      return permission;
    } else {
      return;
    }
  } else {
    return permission;
  }
};

const permissionOHPermissionMap = {
  camera: "ohos.permission.CAMERA",
  geolocation: ["ohos.permission.LOCATION", "ohos.permission.APPROXIMATELY_LOCATION"],
  microphone: "ohos.permission.MICROPHONE",
  // notifications: "ohos.permission.NOTIFICATION",
  // "photos": "ohos.permission.PHOTO",
  // "clipboard-read": "ohos.permission.READ_PASTEBOARD",
  // "clipboard-write": "ohos.permission.CAMERA",
};

const _requestNotificationPermission = async () => {
  const result = await PluginInstance.requestNotificationPermission();

  if (result === true) {
    return { state: "granted" };
  } else {
    return { state: "denied" };
  }
};

const _queryNotificationPermission = async () => {
  const result = await PluginInstance.queryNotificationPermission();

  if (result === true) {
    return { state: "granted" };
  } else {
    return { state: "denied" };
  }
};

const register = (plugin) => {
  if (plugin.registered) {
    return;
  }

  PluginInstance = plugin;
  plugin.registered = true;

  plugin.queryLikeCapacitor = async ({ name }) => {
    if (name === "notifications") {
      return _queryNotificationPermission(name);
    }
    let permission = compatiblePermissionType(name);
    if (!permission) {
      return { state: "unavailable" };
    }
    const results = await plugin.query(permission);

    return Object.values(results).every((s) => s === 0) ? { state: "granted" } : { state: "denied" };
  };

  plugin.requestLikeCapacitor = async ({ name }) => {
    if (name === "notifications") {
      return _requestNotificationPermission(name);
    }

    let permission = compatiblePermissionType(name);
    if (!permission) {
      return { state: "unavailable" };
    }
    const results = await plugin.request(permission);

    return Object.values(results).every((s) => s === 0) ? { state: "granted" } : { state: "denied" };
  };
};

(() => {
  window.__CloakPluginsRegister = window.__CloakPluginsRegister || {};
  window.__CloakPluginsRegister[PluginName] = register;
  if (Cloak && Cloak.plugins && Cloak.plugins[PluginName]) {
    register(Cloak.plugins[PluginName]);
  }
})();

export { register, PluginInstance as Permission };
