// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {GasTest} from "../src/GasTest.sol";

contract GasTestTest is Test {
    GasTest public gasTest;

    function setUp() public {
        gasTest = new GasTest();
    }

    function test_StringGasComparison() public {
        string
            memory testStr = "Hello, World! This is a test string to compare gas costs between memory and calldata";

        uint256 gasBefore;
        uint256 gasAfter;

        // memoryのガス計測
        gasBefore = gasleft();
        gasTest.withMemory(testStr);
        gasAfter = gasleft();
        console.log("Gas used with memory string:", gasBefore - gasAfter);

        // calldataのガス計測
        gasBefore = gasleft();
        gasTest.withCalldata(testStr);
        gasAfter = gasleft();
        console.log("Gas used with calldata string:", gasBefore - gasAfter);
    }

    function test_ArrayGasComparison() public {
        uint256[] memory testArr = new uint256[](10);
        for (uint i = 0; i < 10; i++) {
            testArr[i] = i;
        }

        uint256 gasBefore;
        uint256 gasAfter;

        // memoryのガス計測
        gasBefore = gasleft();
        gasTest.withMemoryArray(testArr);
        gasAfter = gasleft();
        console.log("Gas used with memory array:", gasBefore - gasAfter);

        // calldataのガス計測
        gasBefore = gasleft();
        gasTest.withCalldataArray(testArr);
        gasAfter = gasleft();
        console.log("Gas used with calldata array:", gasBefore - gasAfter);
    }
}
