// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// 本番用のコントラクト
contract Token {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        decimals = 18;
    }

    function mint(uint256 amount) public {
        totalSupply += amount;
        balanceOf[msg.sender] += amount;
    }
}
