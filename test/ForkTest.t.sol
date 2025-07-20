// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "lib/forge-std/src/Test.sol";
import {Token} from "../src/Token.sol";

// テストコード
contract ForkTest is Test {
    // メインネット上の実在するコントラクトアドレス
    address constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address constant BINANCE = 0x28C6c06298d514Db089934071355E5743bf21d60;

    // 自分のトークン
    Token token;

    function setUp() public {
        // 自分のトークンをデプロイ
        token = new Token("My Token", "MTK");

        // テスト用にミント
        token.mint(1000 * 10 ** 18);
    }

    function test_TokenAndUSDC() public {
        // 自分のトークンのテスト
        assertEq(token.totalSupply(), 1000 * 10 ** 18);

        // メインネットのUSDCとの相互作用
        IERC20 usdc = IERC20(USDC);
        uint256 binanceBalance = usdc.balanceOf(BINANCE);

        // Binanceは大量のUSDCを持っているはず
        assertGt(binanceBalance, 0);
        console.log("Binance USDC Balance:", binanceBalance);
    }
}

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function totalSupply() external view returns (uint256);
}
