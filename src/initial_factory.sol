// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "./initial_inscription.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";

contract initial_factory{
    using Clones for address;
    address public inscriptionMarket;
    address [] public tokenAddrs;
    mapping (address => address[]) public clones;

    constructor(address _inscriptionMarket){
        inscriptionMarket = _inscriptionMarket;
    }



    function deployInscription(string memory name, string memory symbol, uint totalSupply, uint perMint) public returns(address){
        address cloneERC20 = inscriptionMarket.clone();
        initial_inscriptionMarket(cloneERC20).initialize(name,  symbol, totalSupply, perMint);
        tokenAddrs.push(cloneERC20);
        return cloneERC20;
    }

    function mintInscription(address tokenAddr) public {
        initial_inscriptionMarket(tokenAddr).mint(msg.sender);
    }

}