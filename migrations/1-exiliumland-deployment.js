const ExiliumLand = artifacts.require("ExiliumLand");

module.exports = function(deployer, network, accounts) {
    deployer.deploy(ExiliumLand, accounts[0]);
}