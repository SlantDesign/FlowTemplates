function createCommonScripts(commonFolderPath) {
  let sources = [
    `${commonFolderPath}/web-animations.min.js`,
    `${commonFolderPath}/Player.js`,
    `${commonFolderPath}/ToggleButton.js`,
    `${commonFolderPath}/HoverElement.js`,
    `${commonFolderPath}/HoverButton.js`
  ];
  loadScripts(sources);
}

createCommonScripts(commonFolderPath);
