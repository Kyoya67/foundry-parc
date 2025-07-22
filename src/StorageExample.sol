// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {console} from "lib/forge-std/src/Test.sol";

contract StorageExample {
    // These variables are stored in slots sequentially
    address public owner;
    uint256 public value;
    bool public isActive;
    string public name;
    bytes32 private constant VALUE_STORAGE_SLOT = bytes32(keccak256("value-storage-slot"));

    constructor() {
        owner = msg.sender;
        value = 0;
        isActive = true;
        name = "Test";
    }

    // Normal access (Solidity does this automatically)
    function setValue(uint256 _newValue) external {
        value = _newValue;
    }

    // Direct slot access with assembly (low-level operation)
    function setValueWithAssembly(uint256 _newValue) external {
        bytes32 slot = VALUE_STORAGE_SLOT;
        assembly {
            sstore(slot, _newValue) // Write to special slot
        }
    }

    function getValueWithAssembly() external view returns (uint256 result) {
        bytes32 slot = VALUE_STORAGE_SLOT;
        assembly {
            result := sload(slot) // Direct read from special slot
        }
    }

    // REAL Storage Inspector - directly read slots with assembly
    function inspectStorage() external view {
        uint256 slot0Value;
        uint256 slot1Value;
        uint256 slot2Value;
        uint256 slot3Value;

        uint256 specialSlotValue;
        bytes32 slot = VALUE_STORAGE_SLOT;

        assembly {
            slot0Value := sload(0)
            slot1Value := sload(1)
            specialSlotValue := sload(slot)
            slot2Value := sload(2)
            slot3Value := sload(3)
        }

        console.log("owner (slot 0):", slot0Value);
        console.log("value (slot 1):", slot1Value);
        console.log("special slot (specialSlot):", specialSlotValue);
        console.log("isActive (slot 2):", slot2Value);
        console.log("name (slot 3):", slot3Value);
    }
}
