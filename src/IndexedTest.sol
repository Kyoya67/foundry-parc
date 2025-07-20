// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract IndexedTest {
    // indexedありのイベント
    event Transfer(
        address indexed from, // インデックス化：高速検索可能
        address indexed to, // インデックス化：高速検索可能
        uint256 amount // インデックス化なし：検索に使えない
    );

    // indexedなしのイベント
    event Message(
        address from, // インデックス化なし
        address to, // インデックス化なし
        string message // インデックス化なし
    );

    function sendTransfer(address to, uint256 amount) public {
        emit Transfer(msg.sender, to, amount);
    }

    function sendMessage(address to, string memory message) public {
        emit Message(msg.sender, to, message);
    }
}
