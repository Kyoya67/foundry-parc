// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {console} from "lib/forge-std/src/Test.sol";

contract LogicV1 {
    // ストレージ変数 - Proxyと同じレイアウトにする必要がある
    bytes32 private constant IMPLEMENTATION_SLOT = bytes32(uint256(keccak256("eip1967.proxy.implementation")) - 1);
    address public owner;

    // LogicV1独自の状態変数
    uint256 public value;
    string public version;

    // 初期化関数（constructorの代わり）
    function initialize(uint256 _value) external {
        require(bytes(version).length == 0, "Already initialized");
        value = _value;
        version = "V1";
        console.log("LogicV1: Initialized with value =", _value);
    }

    function setValue(uint256 _newValue) external {
        console.log("LogicV1: setValue called");
        console.log("LogicV1: old value =", value);
        console.log("LogicV1: new value =", _newValue);

        value = _newValue;
    }

    function getValue() external view returns (uint256) {
        return value;
    }

    function getVersion() external view returns (string memory) {
        return version;
    }

    // V1独自の機能
    function multiply(uint256 _factor) external {
        console.log("LogicV1: multiply called with factor =", _factor);
        console.log("LogicV1: before:", value);

        value = value * _factor;

        console.log("LogicV1: after:", value);
    }
}
