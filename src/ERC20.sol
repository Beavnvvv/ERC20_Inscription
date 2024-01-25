// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "./IERC20.sol";
import "@openzeppelin-contracts/contracts/utils/Address.sol";

    // interface ItokensReceived{
    //     function tokensReceived(
    //         address token,
    //         address sender,
    //         uint amount) external returns(bool);
    // }

    interface ItokensReceived{
        function tokensReceived(
            address sender,
            address recipient,
            uint amount,
            bytes calldata data
        )external returns(bool);
    }
contract ERC20 is IERC20{
    mapping(address => uint256) public override balanceOf;

    mapping(address => mapping(address => uint256)) public override allowance;

    uint256 public override totalSupply;   // 代币总供给

    string public name;   // 名称
    string public symbol;  // 代号
    uint8 public decimals = 18; // 小数位数

    address private owner;
    address public token =address(this);

    modifier onlyowner{
        require(msg.sender == owner,"go away");
        _;
    }

    constructor(string memory name_, string memory symbol_){
        name = name_;
        symbol = symbol_;
        owner = msg.sender;
    }

    function transfer(address recipient, uint amount) external override returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint amount) external override returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external override returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    // function transferWithCallback1(address recipient, uint256 amount) external returns (bool) {
    //     balanceOf[msg.sender] -= amount;
    //     balanceOf[recipient] += amount;
    //     address sender = msg.sender;
    //     if (recipient.code.length > 0 ) {
    //     bool rv = ItokensReceived(recipient).tokensReceived(token,sender,amount);
    //     require(rv, "No tokensReceived");}
    //     return true;
    // }

    function transferWithCallback(address sender, address recipient, uint amount, bytes calldata data) external returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        if (recipient.code.length > 0 ) {
        bool rv = ItokensReceived(recipient).tokensReceived(sender,recipient,amount,data);
        require(rv, "No tokensReceived");}
        return true;
    }

    // function mint(uint amount) external onlyowner{
    //     balanceOf[msg.sender] += amount;
    //     totalSupply += amount;
    //     emit Transfer(address(0), msg.sender, amount);
    // }

    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

    function _mint(address tokenAddr, uint perMint) internal {
        balanceOf[tokenAddr] += perMint;
        totalSupply += perMint;
    }



}//0x7aB741E09419ECeef86570A686C097bc4a38006b
//0xB2899ed527F8Fd70351B87a5Db7183e2eA770Ea1
//0x56dB33419569190B04efcD9BED19b6759F73b9b4