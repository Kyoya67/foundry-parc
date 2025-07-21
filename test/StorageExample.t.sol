// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "lib/forge-std/src/Test.sol";
import {StorageExample} from "../src/StorageExample.sol";

contract StorageExampleTest is Test {
    StorageExample public storageExample;

    function setUp() public {
        storageExample = new StorageExample();
        console.log("=== Contract Deployed ===");
    }

    function test_BasicStorage() public {
        console.log("=== Basic Storage Operations ===");

        // Check initial state
        storageExample.inspectStorage();

        // Change value normally
        console.log("\n--- Normal setValue ---");
        storageExample.setValue(999);
        storageExample.inspectStorage();

        // Change value with assembly
        console.log("\n--- Assembly setValue ---");
        storageExample.setValueWithAssembly(777);
        storageExample.inspectStorage();

        // Read value with assembly
        uint256 assemblyValue = storageExample.getValueWithAssembly();
        console.log("Value read with assembly:", assemblyValue);

        // Verify results are the same
        assertEq(storageExample.value(), 777);
        assertEq(assemblyValue, 777);
    }
}
