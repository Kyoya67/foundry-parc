// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/console.sol";

contract Event {
    event WithIndexed(address indexed from, uint256 value);
    event WithoutIndexed(address from, uint256 value);

    function emitWithIndexed(uint256 value) public {
        emit WithIndexed(msg.sender, value);
    }

    function emitWithoutIndexed(uint256 value) public {
        emit WithoutIndexed(msg.sender, value);
    }
}
