// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Navich2 is ERC20, Pausable {

    ERC20 immutable navich;
    address public immutable contractOwner;
    uint256 public constant MAX_SUPPLY = 55555;

    constructor(address _navich) ERC20("Navich 2.0", "NAVICH2.0") {
        navich = ERC20(_navich);
        contractOwner = msg.sender;
    }

    function buyNavich2(uint256 tokensAmount) public whenNotPaused {

        require(balanceOf(msg.sender) == 0, "Tokens already minted at this address");
        require(totalSupply() + tokensAmount <= MAX_SUPPLY, "Sold out =D");

        navich.transferFrom(msg.sender, contractOwner, tokensAmount);
        _mint(msg.sender, tokensAmount);
    }

    function pauseContract() external {
        _pause();
    }
    function unPauseContract() external {
        _unpause();
    }
    
}

