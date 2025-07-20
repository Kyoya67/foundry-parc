// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// 📦 DEPENDENCIES
import {Test, console} from "lib/forge-std/src/Test.sol";
import {GasTest} from "../src/GasTest.sol";

contract GasTestTest is Test {
    GasTest public gasTest;

    function setUp() public {
        gasTest = new GasTest();
    }

    function test_StringGasComparison() public {
        string memory testStr = "Hello, World!";

        uint256 gasBefore;
        uint256 gasAfter;

        // ストレージのガス計測
        gasBefore = gasleft();
        gasTest.withStorage(testStr);
        gasAfter = gasleft();
        console.log("Gas used with storage string:", gasBefore - gasAfter);

        // メモリのガス計測
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
}
