// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract GasTest {
    // memoryを使用する関数
    function withMemory(string memory str) public pure returns (string memory) {
        return str;
    }

    // calldataを使用する関数
    function withCalldata(
        string calldata str
    ) public pure returns (string memory) {
        return str;
    }

    // 配列でのmemoryテスト
    function withMemoryArray(
        uint256[] memory arr
    ) public pure returns (uint256[] memory) {
        return arr;
    }

    // 配列でのcalldataテスト
    function withCalldataArray(
        uint256[] calldata arr
    ) public pure returns (uint256[] memory) {
        return arr;
    }
}
