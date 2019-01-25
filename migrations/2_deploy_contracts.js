var Ticketing = artifacts.require("Ticketing");

module.exports = function(deployer) {
  deployer.deploy(Ticketing, 1000, 100000000000000, "Pink Floyd - Paris", "PFP2019");
};
