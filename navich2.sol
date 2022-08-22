// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Navich2 is ERC20 {

    ERC20 immutable navich;
    address public immutable contractOwner;
    uint256 public constant MAX_SUPPLY = 55555;
    uint256 public constant NAVICH_2_PRICE = 2;

    constructor(address _navich) ERC20("Navich 2.0", "NAVICH2") {
        navich = ERC20(_navich);
        contractOwner = msg.sender;
    }

    function buyNavich2(uint256 tokensAmount, uint256 _amountFee) public payable {

        navich.transferFrom(msg.sender, contractOwner, _amountFee);

        uint256 publicFee  = tokensAmount * NAVICH_2_PRICE;
        uint256 privateSaleFee = publicFee/2; 
        uint256 saleStart = block.timestamp + 3600;           // Sale Starts in 1 hour
        uint256 saleEnd = saleStart + 18000;                  //Sale Ends after 5 hours

        require(totalSupply() + tokensAmount <= MAX_SUPPLY, "Sold out =D");

        if(block.timestamp >= saleStart && block.timestamp <= saleEnd /*&& tokenPriceOnSale != 0*/){
            require(_amountFee == privateSaleFee, "Not Enough Fee on-Sale");
        } else {
            require(_amountFee == publicFee, "Not Enough Fee");
        }

        _mint(msg.sender, tokensAmount);
    }
}
