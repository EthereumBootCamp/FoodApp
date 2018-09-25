var foodApp = artifacts.require("./foodApp.sol");

module.exports = function(deployer) {
  deployer.deploy(foodApp);
};
