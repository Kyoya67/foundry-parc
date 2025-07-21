// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "lib/forge-std/src/Test.sol";
import "../src/Event.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract EventTest is Test {
    Event eventTest;

    function setUp() public {
        eventTest = new Event();
        console.log("eventTest address:", address(eventTest));
        console.log("msg.sender:", address(this));
    }

    function testEmitWithIndexed() public {
        vm.recordLogs();
        eventTest.emitWithIndexed(123);
        Vm.Log[] memory entries = vm.getRecordedLogs();

        emit log("=== With Indexed ===");
        for (uint256 i = 0; i < entries.length; i++) {
            emit log_named_uint("topics.length", entries[i].topics.length);
            for (uint256 j = 0; j < entries[i].topics.length; j++) {
                string memory label = string(abi.encodePacked("topic[", Strings.toString(j), "]"));
                emit log_named_bytes32(label, entries[i].topics[j]);
            }

            console.log("data length:", entries[i].data.length);
            console.logBytes(entries[i].data);
        }
    }

    function testEmitWithoutIndexed() public {
        vm.recordLogs();
        eventTest.emitWithoutIndexed(123);
        Vm.Log[] memory entries = vm.getRecordedLogs();

        emit log("=== Without Indexed ===");
        for (uint256 i = 0; i < entries.length; i++) {
            emit log_named_uint("topics.length", entries[i].topics.length);
            for (uint256 j = 0; j < entries[i].topics.length; j++) {
                string memory label = string(abi.encodePacked("topic[", Strings.toString(j), "]"));
                emit log_named_bytes32(label, entries[i].topics[j]);
            }

            console.log("data length:", entries[i].data.length);
            console.logBytes(entries[i].data);
        }
    }
}
