// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract OpCodeTest {
    // ストレージ変数（SLOAD/SSTOREのターゲット）
    uint256 public x;

    // イベント定義（LOGのターゲット）
    event MyEvent(address indexed who, uint256 value);

    // SSTOREを使用：ストレージに書き込み
    function write(uint256 value) public {
        x = value; // これがSSTOREを使用
    }

    // SLOADを使用：ストレージから読み取り
    function read() public view returns (uint256) {
        return x; // これがSLOADを使用
    }

    // LOGを使用：イベントの発行
    function logEvent(uint256 value) public {
        emit MyEvent(msg.sender, value); // これがLOGを使用
    }
}
