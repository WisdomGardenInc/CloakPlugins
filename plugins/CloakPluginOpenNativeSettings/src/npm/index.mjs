let PluginInstance = null;
const PluginName = 'NativeSettings'
const register = (plugin) => {
  if (plugin.registered) {
    return;
  }
  plugin.registered = true;
  PluginInstance = plugin;
};

(() => {
  window.__CloakPluginsRegister = window.__CloakPluginsRegister || {};
  window.__CloakPluginsRegister[PluginName] = register;
  if (Cloak && Cloak.plugins && Cloak.plugins[PluginName]) {
    register(Cloak.plugins[PluginName]);
  }
})();

export {
  register,
  PluginInstance as NativeSettings
};