// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Navich2 is ERC20, Pausable {

    ERC20 immutable navich;
    address public immutable contractOwner;
    uint256 public constant MAX_SUPPLY = 55;
    uint256 public constant NAVICH_2_PRICE = 2;

    constructor(address _navich) ERC20("Navich 2.0", "NAVICH2.0") {
        navich = ERC20(_navich);
        contractOwner = msg.sender;
    }

    function buyNavich2(uint256 navichFee, uint256 navich2Amount) public whenNotPaused {

        uint256 publicFee  = navich2Amount * NAVICH_2_PRICE;
        uint256 privateSaleFee = publicFee/2; 
        uint256 saleStart = block.timestamp + 3600;           // Sale Starts in 1 hour
        uint256 saleEnd = saleStart + 18000;

        require(balanceOf(msg.sender) == 0, "Tokens already minted at this address");
        require(totalSupply() + navich2Amount <= MAX_SUPPLY, "Sold out =D");

        if(block.timestamp >= saleStart && block.timestamp <= saleEnd){
            require(navichFee == privateSaleFee, "Not Enough Fee on-Sale");
        } else {
            require(navichFee == publicFee, "Not Enough Fee");
        }

        navich.transferFrom(msg.sender, contractOwner, navichFee);
        _mint(msg.sender, navich2Amount);
    }

    function pauseContract() external {
        _pause();
    }
    function unPauseContract() external {
        _unpause();
    }
    
}

