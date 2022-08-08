pragma solidity 0.8.15;

// address:  0x069eEc21e749624ee9624b7A823b0bf7275fbcA0
contract MyDice {

   //contract creator
    address payable private owner = payable(msg.sender);

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

   //The homeowner recharges the contract wallet
    function recharge() onlyOwner payable public {
    }

   //The host takes the initiative to withdraw cash from the contract wallet
    function withdraw(uint32 _amount) onlyOwner public {
        owner.transfer(_amount);
    }

   //solidity cannot return structure, but can return tuples
   //@param _num is the selected number between [1, 99]
   //@return (player chooses numbers, chips, generated numbers, payout chips)
    function play(uint8 _num) payable public
            returns (uint8, uint256, uint8, uint256) {

        require(_num >= 1 && _num <= 99);

       //Generate random numbers of [0, 99]
        uint8 tval = randomInt(0, 99);

        if (tval <_num) {
           //Calculate the value of the payout
            uint256 payout = uint256(msg.value * 100/_num);
            payable(msg.sender).transfer(payout);
            return (_num, msg.value, tval, payout);
        } else {
            return (_num, msg.value, tval, 0);
        }

    }

   //Generate a random number between [min, max]
    function randomInt(uint8 min, uint8 max) private
            view returns(uint8) {

        require(max> min);

        bytes32 hash = keccak256(
            abi.encodePacked(block.timestamp, msg.sender, block.difficulty)
        );

        return uint8(uint256(hash)% (max-min + 1)) + min;

    }

}