var HelloWorld = artifacts.require("HelloWorld");
var MyDice = artifacts.require("Dice");

module.exports = function(deployer) {
    deployer.deploy(HelloWorld, "hello");
    // Additional contracts can be deployed here
    deployer.deploy(MyDice, "dice");
};