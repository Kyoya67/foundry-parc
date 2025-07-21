// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {console} from "lib/forge-std/src/Test.sol";

contract LogicV2 {
    // ストレージレイアウトはV1と同じにする
    bytes32 private constant IMPLEMENTATION_SLOT = bytes32(uint256(keccak256("eip1967.proxy.implementation")) - 1);
    address public owner;
    uint256 public value;
    string public version;

    // V2で追加された状態変数
    uint256 public multiplier;

    // アップグレード時の初期化関数
    function initializeV2(uint256 _multiplier) external {
        require(keccak256(bytes(version)) == keccak256(bytes("V1")), "Not upgrading from V1");
        version = "V2";
        multiplier = _multiplier;
        console.log("LogicV2: Upgraded to V2 with multiplier =", _multiplier);
    }

    function setValue(uint256 _newValue) external {
        console.log("LogicV2: setValue called (UPGRADED VERSION)");
        console.log("LogicV2: old value =", value);
        console.log("LogicV2: new value =", _newValue);

        value = _newValue;
    }

    function getValue() external view returns (uint256) {
        return value;
    }

    function getVersion() external view returns (string memory) {
        return version;
    }

    function getMultiplier() external view returns (uint256) {
        return multiplier;
    }

    // V1のmultiplyを改良
    function multiply(uint256 _factor) external {
        console.log("LogicV2: multiply called (UPGRADED VERSION)");
        console.log("LogicV2: factor =", _factor);
        console.log("LogicV2: multiplier =", multiplier);
        console.log("LogicV2: before:", value);

        // V2では内部のmultiplierも考慮
        value = value * _factor * multiplier;

        console.log("LogicV2: after:", value);
    }

    // V2で新しく追加された機能
    function add(uint256 _amount) external {
        console.log("LogicV2: add called (NEW FEATURE)");
        console.log("LogicV2: adding:", _amount);
        console.log("LogicV2: before:", value);

        value = value + _amount;

        console.log("LogicV2: after:", value);
    }

    function setMultiplier(uint256 _newMultiplier) external {
        console.log("LogicV2: setMultiplier called (NEW FEATURE)");
        multiplier = _newMultiplier;
        console.log("LogicV2: multiplier set to:", _newMultiplier);
    }
}
