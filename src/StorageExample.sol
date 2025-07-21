// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {console} from "lib/forge-std/src/Test.sol";

contract StorageExample {
    // These variables are stored in slots sequentially
    address public owner; // Slot 0
    uint256 public value; // Slot 1
    bool public isActive; // Slot 2
    string public name; // Slot 3

    constructor() {
        owner = msg.sender;
        value = 123;
        isActive = true;
        name = "Test";
    }

    // Normal access (Solidity does this automatically)
    function setValue(uint256 _newValue) external {
        value = _newValue; // Compiler automatically stores to slot 1
    }

    // Direct slot access with assembly (low-level operation)
    function setValueWithAssembly(uint256 _newValue) external {
        assembly {
            sstore(1, _newValue) // Direct write to slot 1
        }
    }

    function getValueWithAssembly() external view returns (uint256 result) {
        assembly {
            result := sload(1) // Direct read from slot 1
        }
    }

    // REAL Storage Inspector - directly read slots with assembly
    function inspectStorage() external view {
        console.log("=== Storage Inspector ===");

        uint256 slot0Value;
        uint256 slot1Value;
        uint256 slot2Value;
        uint256 slot3Value;

        assembly {
            slot0Value := sload(0)
            slot1Value := sload(1)
            slot2Value := sload(2)
            slot3Value := sload(3)
        }

        console.log("Raw Slot 0:", slot0Value);
        console.log("Raw Slot 1:", slot1Value);
        console.log("Raw Slot 2:", slot2Value);
        console.log("Raw Slot 3:", slot3Value);
    }
}
