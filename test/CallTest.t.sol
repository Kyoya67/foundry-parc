// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Target, Caller} from "../src/CallTest.sol";

contract CallTestTest is Test {
    Target public target;
    Caller public caller;

    function setUp() public {
        target = new Target();
        caller = new Caller(target);
        console.log("=== SETUP ===");
        console.log("CallTestTest address:", address(this));
        console.log("Target address:", address(target));
        console.log("Caller address:", address(caller));
    }

    function test_NormalCall() public {
        console.log("=== BEFORE NORMAL CALL ===");
        console.log("Target value:", target.value());
        console.log("Target owner:", target.owner());
        console.log("Caller value:", caller.value());
        console.log("Caller owner:", caller.owner());

        caller.normalCall(123);

        console.log("=== AFTER NORMAL CALL ===");
        console.log("Target value:", target.value());
        console.log("Target owner:", target.owner());
        console.log("Caller value:", caller.value());
        console.log("Caller owner:", caller.owner());
    }

    function test_DelegateCall() public {
        console.log("=== BEFORE DELEGATE CALL ===");
        console.log("Target value:", target.value());
        console.log("Target owner:", target.owner());
        console.log("Caller value:", caller.value());
        console.log("Caller owner:", caller.owner());
        caller.delegateCall(456);

        console.log("=== AFTER DELEGATE CALL ===");
        console.log("Target value:", target.value());
        console.log("Target owner:", target.owner());
        console.log("Caller value:", caller.value());
        console.log("Caller owner:", caller.owner());
    }
}
