// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "lib/forge-std/src/Test.sol";
import {Proxy} from "../src/proxy/Proxy.sol";
import {LogicV1} from "../src/proxy/LogicV1.sol";
import {LogicV2} from "../src/proxy/LogicV2.sol";

// ProxyをLogicV1として使うためのインターフェース
interface ILogicV1 {
    function initialize(uint256 _value) external;
    function setValue(uint256 _newValue) external;
    function getValue() external view returns (uint256);
    function getVersion() external view returns (string memory);
    function multiply(uint256 _factor) external;
}

// ProxyをLogicV2として使うためのインターフェース
interface ILogicV2 {
    function initializeV2(uint256 _multiplier) external;
    function setValue(uint256 _newValue) external;
    function getValue() external view returns (uint256);
    function getVersion() external view returns (string memory);
    function getMultiplier() external view returns (uint256);
    function multiply(uint256 _factor) external;
    function add(uint256 _amount) external;
    function setMultiplier(uint256 _newMultiplier) external;
}

contract ProxyTest is Test {
    Proxy public proxy;
    LogicV1 public logicV1;
    LogicV2 public logicV2;

    // Proxyをそれぞれのインターフェースとして使用
    ILogicV1 public proxyAsV1;
    ILogicV2 public proxyAsV2;

    function setUp() public {
        console.log("=== SETUP ===");

        // Logic契約をデプロイ
        logicV1 = new LogicV1();
        logicV2 = new LogicV2();

        console.log("LogicV1 deployed at:", address(logicV1));
        console.log("LogicV2 deployed at:", address(logicV2));

        // ProxyをLogicV1を指すようにデプロイ
        proxy = new Proxy(address(logicV1));

        console.log("Proxy deployed at:", address(proxy));
        console.log("Proxy implementation:", proxy.implementation());

        // インターフェースとしてのキャスト
        proxyAsV1 = ILogicV1(address(proxy));
        proxyAsV2 = ILogicV2(address(proxy));
    }

    function test_ProxyWithV1() public {
        console.log("=== TEST: Proxy with LogicV1 ===");

        // V1として初期化
        proxyAsV1.initialize(100);

        console.log("Value:", proxyAsV1.getValue());
        console.log("Version:", proxyAsV1.getVersion());

        // V1の機能をテスト
        proxyAsV1.setValue(200);
        assertEq(proxyAsV1.getValue(), 200);

        proxyAsV1.multiply(3);
        assertEq(proxyAsV1.getValue(), 600);

        console.log("Final value:", proxyAsV1.getValue());
    }

    function test_UpgradeToV2() public {
        console.log("=== TEST: Upgrade from V1 to V2 ===");

        // まずV1として初期化
        proxyAsV1.initialize(50);
        proxyAsV1.setValue(100);

        console.log("Before upgrade:");
        console.log("Value:", proxyAsV1.getValue());
        console.log("Version:", proxyAsV1.getVersion());

        // V2にアップグレード
        console.log("=== UPGRADING TO V2 ===");
        proxy.upgrade(address(logicV2));

        console.log("New implementation:", proxy.implementation());

        // V2として初期化
        proxyAsV2.initializeV2(2);

        console.log("After upgrade:");
        console.log("Value:", proxyAsV2.getValue()); // データは保持される
        console.log("Version:", proxyAsV2.getVersion());
        console.log("Multiplier:", proxyAsV2.getMultiplier());

        // V2の改良されたmultiply機能をテスト
        console.log("=== Testing V2 improved multiply ===");
        proxyAsV2.multiply(2); // value * factor * multiplier = 100 * 2 * 2 = 400
        assertEq(proxyAsV2.getValue(), 400);

        // V2の新機能をテスト
        console.log("=== Testing V2 new features ===");
        proxyAsV2.add(100); // 400 + 100 = 500
        assertEq(proxyAsV2.getValue(), 500);

        proxyAsV2.setMultiplier(5);
        assertEq(proxyAsV2.getMultiplier(), 5);

        console.log("Final value:", proxyAsV2.getValue());
        console.log("Final multiplier:", proxyAsV2.getMultiplier());
    }

    function test_StoragePersistence() public {
        console.log("=== TEST: Storage Persistence ===");

        // V1で値を設定
        proxyAsV1.initialize(777);
        proxyAsV1.setValue(999);

        uint256 valueBeforeUpgrade = proxyAsV1.getValue();
        console.log("Value before upgrade:", valueBeforeUpgrade);

        // V2にアップグレード
        proxy.upgrade(address(logicV2));
        proxyAsV2.initializeV2(3);

        uint256 valueAfterUpgrade = proxyAsV2.getValue();
        console.log("Value after upgrade:", valueAfterUpgrade);

        // ストレージが保持されていることを確認
        assertEq(valueBeforeUpgrade, valueAfterUpgrade);

        console.log("Storage persistence verified!");
    }
}
