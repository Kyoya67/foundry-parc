// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "lib/forge-std/src/Test.sol";
import {StorageExample} from "../src/StorageExample.sol";

contract StorageExampleTest is Test {
    StorageExample public storageExample;

    function setUp() public {
        storageExample = new StorageExample();
    }

    function test_BasicStorage() public {
        console.log("=== Initial State ===");
        storageExample.inspectStorage();

        console.log("=== Normal setValue ===");
        storageExample.setValue(999);
        storageExample.inspectStorage();

        console.log("=== Assembly setValue ===");
        storageExample.setValueWithAssembly(777);
        storageExample.inspectStorage();

        uint256 assemblyValue = storageExample.getValueWithAssembly();
        console.log("Value read with assembly:", assemblyValue);

        assertEq(storageExample.value(), 999);
        assertEq(assemblyValue, 777);
    }
}
