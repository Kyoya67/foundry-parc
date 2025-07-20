// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script} from "lib/forge-std/src/Script.sol";
import {Token} from "../src/Token.sol";

// デプロイ用スクリプト
contract DeployToken is Script {
    function run() external {
        // デプロイのための秘密鍵を使用開始
        vm.startBroadcast();

        // トークンをデプロイ
        Token token = new Token("My Token", "MTK");

        // 初期供給量をミント
        token.mint(1000000 * 10 ** 18);

        vm.stopBroadcast();
    }
}
