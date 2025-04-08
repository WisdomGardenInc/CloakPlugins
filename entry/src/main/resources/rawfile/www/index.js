window.document.addEventListener(
  "CloakReady",
  () => {
    showUserAgent();
    displayFrameworkInfo();
    displayPluginsInfo();
  },
  { once: true }
);

const showUserAgent = () => {
  document.getElementById("userAgent").innerText = window.location.href + "\n" + window.navigator.userAgent;
};

const displayFrameworkInfo = () => {
  const pluginsInfoDiv = document.getElementById("frameworkInfo");
  if (!window.Cloak) {
    return;
  }
  pluginsInfoDiv.innerHTML = JSON.stringify(Cloak.metadata, null, 2);
};

const displayPluginsInfo = () => {
  const pluginsInfoDiv = document.getElementById("pluginsInfo");
  pluginsInfoDiv.innerHTML = "";

  if (window.Cloak && window.Cloak.plugins) {
    const plugins = window.Cloak.plugins;
    for (const pluginName in plugins) {
      if (plugins.hasOwnProperty(pluginName)) {
        const plugin = plugins[pluginName];
        const metadata = plugin.getMetadata();
        const pluginInfo = document.createElement("div");
        pluginInfo.className = "plugin-item";
        pluginInfo.innerHTML = `
                    <h3>📦 ${metadata.name}</h3>
                    <p>Version: ${metadata.version}</p>
                    <p>Methods: ${metadata.methods.join(", ")}</p>
                    <p>${metadata.description}</p>
                `;
        pluginsInfoDiv.appendChild(pluginInfo);
      }
    }
  } else {
    pluginsInfoDiv.textContent = "No plugins installed.";
  }
};

// permission
const queryPermissions = async (permissions) => {
  const result = await Cloak.plugins.Permission.query(permissions);
  // const result = await Cloak.plugins.Permission.requestGlobalSwitch(2);
  alert(JSON.stringify(result, null, 2));
};

const requestPermissions = async (permissions) => {
  const result = await Cloak.plugins.Permission.request(permissions);
  alert(JSON.stringify(result, null, 2));
};

const queryNotificationPermission = async () => {
  const result = await Cloak.plugins.Permission.queryNotificationPermission();
  alert(result);
  // const result = await Cloak.plugins.Permission.queryLikeCapacitor({ name: "notifications" });
  // alert(JSON.stringify(result, null, 2));
};

const requestNotificationPermission = async () => {
  const result = await Cloak.plugins.Permission.requestNotificationPermission();
  alert(result);
  // const result = await Cloak.plugins.Permission.requestLikeCapacitor({ name: "notifications" });
  // alert(JSON.stringify(result, null, 2));
};

// in app browser
const onOpenUrl = async (url) => {
  const browser = Cloak.plugins.InAppBrowser.create(url, "_blank", { clearcache: true });

  browser.open();
};

// http
const httpGet = async () => {
  const url = "https://api.restful-api.dev/objects";
  const response = await Cloak.plugins.Http.sendRequest(url);
  alert(JSON.stringify(response.data, null, 2));
};

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
  alert(JSON.stringify(response.data, null, 2));
};
