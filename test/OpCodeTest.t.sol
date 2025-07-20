// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {OpCodeTest} from "../src/OpCodeTest.sol";

contract OpCodeTestTest is Test {
    OpCodeTest public opTest;

    function setUp() public {
        opTest = new OpCodeTest();
    }

    function testGasUsage() public {
        uint256 gasBefore;
        uint256 gasAfter;

        // SSTOREのガス測定
        gasBefore = gasleft();
        opTest.write(123);
        gasAfter = gasleft();
        console.log("SSTORE gas used:", gasBefore - gasAfter);

        // SLOADのガス測定
        gasBefore = gasleft();
        opTest.read();
        gasAfter = gasleft();
        console.log("SLOAD gas used:", gasBefore - gasAfter);

        // LOGのガス測定
        gasBefore = gasleft();
        opTest.logEvent(456);
        gasAfter = gasleft();
        console.log("LOG gas used:", gasBefore - gasAfter);
    }
}
