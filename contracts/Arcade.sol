// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./CreditToken.sol";

contract Arcade {
    address CreditTokenAddress;
    address MagicTokenAddress;
    address admin;
    mapping(address => uint) timerPlayer;
    mapping(address => bool) playerPaid;

    constructor(address _MagicToken){
        admin = msg.sender;
        MagicTokenAddress = _MagicToken;
    }

    modifier onlyAdmin{
        require(msg.sender == admin);
        _;
    }

    function addCreditAddress(address _token) public onlyAdmin(){
        CreditTokenAddress = _token;
    }

    function buyCredit(uint _amount) public {
        require(_amount >= 1 && _amount <= 10, "Required to buy at least 1 token and maximum of 10 tokens!");
        ERC20 magic = ERC20(MagicTokenAddress);
        require(magic.balanceOf(msg.sender) >= _amount * 5 ether, "Required sender to have amount of tokens in wallet!");
        //require(magic.allowance(msg.sender, address(this) ) >= _amount, "Required to approve amount of magic tokens to this contract allowance!");
        magic.transferFrom(msg.sender, address(this), _amount * 5 ether);
        CreditToken credit = CreditToken(CreditTokenAddress);
        credit.mint(msg.sender, _amount * 10**18);
    }

    function playGame() public{
        CreditToken credit = CreditToken(CreditTokenAddress);
        require(credit.balanceOf(msg.sender) >= 1 ether, "You need at least 1 credit token to play!");
        credit.burn(msg.sender, 1 ether);

        playerPaid[msg.sender] = true;
        timerPlayer[msg.sender] = block.timestamp;

    }
    function endGame(address _user) public onlyAdmin(){
        playerPaid[_user] = false;
        timerPlayer[_user] = 0;
    }

    function withdrawMagic() external onlyAdmin(){
        ERC20 magic = ERC20(MagicTokenAddress);
        magic.transfer(payable(admin),magic.balanceOf(admin));
    }

}