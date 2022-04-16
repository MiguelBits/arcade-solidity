// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MagicToken is ERC20 {

    constructor() ERC20("MAGIC","MAGIC"){

    }

    function saveThatMoney() external{
        _mint(msg.sender, 100 ether);//100ether
    }
}