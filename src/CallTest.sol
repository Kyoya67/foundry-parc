// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {console} from "lib/forge-std/src/Test.sol";

// ターゲットコントラクト（呼び出される側）
contract Target {
    uint256 public value;
    address public owner;

    function setValue(uint256 _value) public {
        console.log("Target: setValue called");
        console.log("Target: msg.sender =", msg.sender);
        console.log("Target: address(this) =", address(this));

        value = _value;
        owner = msg.sender;
    }

    function getValue() public view returns (uint256) {
        return value;
    }
}

// 呼び出し元コントラクト
contract Caller {
    uint256 public value;
    address public owner;
    Target public target;

    constructor(Target _target) {
        target = _target;
    }

    // 通常のcall
    function normalCall(uint256 _value) public {
        console.log("=== NORMAL CALL ===");
        console.log("Caller: before call, value =", value);
        console.log("Caller: before call, owner =", owner);

        target.setValue(_value);

        console.log("Caller: after call, value =", value);
        console.log("Caller: after call, owner =", owner);
        console.log("Target value:", target.getValue());
    }

    // delegatecall
    function delegateCall(uint256 _value) public {
        console.log("=== DELEGATE CALL ===");
        console.log("Caller: before delegatecall, value =", value);
        console.log("Caller: before delegatecall, owner =", owner);

        // delegatecallを使用してTargetのsetValue関数を呼び出し
        bytes memory data = abi.encodeWithSignature(
            "setValue(uint256)",
            _value
        );
        (bool success, ) = address(target).delegatecall(data);
        require(success, "Delegatecall failed");

        console.log("Caller: after delegatecall, value =", value);
        console.log("Caller: after delegatecall, owner =", owner);
        console.log("Target value:", target.getValue());
    }
}
