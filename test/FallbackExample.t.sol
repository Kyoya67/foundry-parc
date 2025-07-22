// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "lib/forge-std/src/Test.sol";
import {FallbackExample} from "../src/FallbackExample.sol";

contract FallbackExampleTest is Test {
    FallbackExample public fallbackExample;

    function setUp() public {
        fallbackExample = new FallbackExample();
        console.log("=== Contract Deployed ===");
        console.log("Initial counter:", fallbackExample.counter());
    }

    function test_NormalFunction() public {
        console.log("=== Normal Function Call ===");

        // Call normal function
        fallbackExample.increment();

        uint256 newCounter = fallbackExample.counter();
        console.log("Counter after increment:", newCounter);
        assertEq(newCounter, 1);
    }

    function test_FallbackFunction() public {
        console.log("=== Fallback Function Call ===");

        // Call non-existent function (low-level call)
        (bool success, bytes memory data) =
            address(fallbackExample).call(abi.encodeWithSignature("nonExistentFunction()"));

        console.log("Call success:", success);

        uint256 newCounter = fallbackExample.counter();
        console.log("Counter after fallback:", newCounter);
        assertEq(newCounter, 10); // fallbackで+10される
    }

    function test_ReceiveFunction() public {
        console.log("=== Receive Function Call ===");

        // Send ETH (no data)
        (bool success,) = address(fallbackExample).call{value: 1 ether}("");

        console.log("ETH send success:", success);

        uint256 newCounter = fallbackExample.counter();
        console.log("Counter after receive:", newCounter);
        assertEq(newCounter, 100); // receiveで+100される
    }

    function test_FallbackWithData() public {
        console.log("=== Fallback with Custom Data ===");

        // Call non-existent function with custom data
        (bool success,) =
            address(fallbackExample).call(abi.encodeWithSignature("customFunction(uint256,string)", 123, "test"));

        console.log("Call success:", success);

        uint256 newCounter = fallbackExample.counter();
        console.log("Counter after custom fallback:", newCounter);
        assertEq(newCounter, 10); // fallbackで+10される
    }
}
