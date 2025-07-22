// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {console} from "lib/forge-std/src/Test.sol";

contract FallbackExample {
    uint256 public counter = 0;

    // Normal function
    function increment() external {
        counter++;
        console.log("increment() called, counter =", counter);
    }

    function getCounter() external view returns (uint256) {
        return counter;
    }

    // fallback function - executed when non-existent function is called
    fallback() external payable {
        console.log("fallback() called!");
        console.log("Function signature:", string(msg.data));
        counter += 10; // Counter increases by 10 when fallback is called
    }

    // receive function - executed when ETH is sent (no data)
    receive() external payable {
        console.log("receive() called!");
        console.log("ETH received:", msg.value);
        counter += 100; // Counter increases by 100 when ETH is received
    }
}
