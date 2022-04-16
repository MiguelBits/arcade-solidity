// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CreditToken is ERC20 {
    address factory;
    modifier onlyFactory(){
        require(factory == msg.sender);
        _;
    }
    constructor(address _factory) ERC20("CREDIT","CREDIT"){
        //_mint(msg.sender,100000000000000000000);//100ether
        factory = _factory;
    }

    function giveCredit() external{
        _mint(msg.sender, 100 ether);//100ether
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        return false;
    }
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        return false;
    }
}