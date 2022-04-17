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

    function mint(address _who, uint _howmuch) public onlyFactory(){
        _mint(_who,_howmuch);
    }
    function burn(address _sender, uint _amount) external onlyFactory(){
        _burn(_sender,_amount);
    }
}