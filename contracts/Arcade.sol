// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Arcade {
    address CreditToken;
    address MagicToken;
    address admin;

    constructor(address _MagicToken){
        admin = msg.sender;
        MagicToken = _MagicToken;
    }

    modifier onlyAdmin{
        require(msg.sender == admin);
        _;
    }

    function addCreditAddress(address _token) public onlyAdmin{
        CreditToken = _token;
    }

    function buyCredit(uint _amount) public {
        require(_amount % 5 == 0, "Required Magic tokens amount to be divisible by 5!");
        ERC20 magic = ERC20(MagicToken);
        require(magic.balanceOf(msg.sender) >= _amount, "Required sender to have amount of tokens in wallet!");
        
    }


}