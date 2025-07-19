// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract GasTest {
    string public storageStr;
    uint256[] public storageArray;

    // ストレージに書き込むテスト
    function withStorage(string memory str) public {
        storageStr = str; // ストレージに書き込み
    }

    // メモリを使用するテスト
    function withMemory(string memory str) public pure returns (string memory) {
        string memory temp = str; // メモリ内でコピー
        return temp;
    }

    // calldataを使用するテスト
    function withCalldata(
        string calldata str
    ) public pure returns (string memory) {
        return str; // calldataを直接返す
    }
}
