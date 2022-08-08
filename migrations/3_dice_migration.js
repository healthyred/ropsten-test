var MyDice = artifacts.require("MyDice");

module.exports = function(deployer) {
    deployer.deploy(MyDice, "dice");
};