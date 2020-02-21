function createCommonScripts(commonFolderPath) {
  let sources = [
    `${commonFolderPath}/web-animations.min.js`,
    `${commonFolderPath}/Animation.js`,
    `${commonFolderPath}/Track.js`,
    `${commonFolderPath}/Player.js`,
    `${commonFolderPath}/ToggleButton.js`,
    `${commonFolderPath}/TextInput.js`
  ];
  loadScripts(sources);
}

createCommonScripts(commonFolderPath);
