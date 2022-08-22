// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Navich is ERC20 {
    constructor(uint amount) ERC20("Navich", "NAVICH") {
        _mint(msg.sender, amount);
    }
}
