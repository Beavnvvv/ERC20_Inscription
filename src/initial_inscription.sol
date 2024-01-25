// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "../ERC20/ERC20.sol";
contract initial_inscriptionMarket is ERC20{

    uint public perMint;
    address private owner;

    constructor() ERC20("",""){
        
    }


    function initialize(string memory _name, string memory _symble, uint _totalSupply, uint _perMint) external {
        name = _name;
        symbol = _symble;
        totalSupply = _totalSupply;
        perMint = _perMint;
    }

    function mint(address tokenAddr) external {
        _mint(tokenAddr, perMint);
    }


}