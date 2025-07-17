// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract VariableTypes {
    // 整数型（符号なし）
    uint256 public myNumber = 123; // 256ビット
    uint8 public smallNumber = 255; // 8ビット
    uint public defaultNumber = 100; // uint256の省略形

    // 整数型（符号あり）
    int256 public signedNumber = -123; // 負の数も可能
    int8 public smallSigned = -128; // 8ビット
    int public defaultSigned = -100; // int256の省略形

    // 文字列
    string public myString = "Hello"; // 動的な長さの文字列

    // 真偽値
    bool public myBool = true; // trueまたはfalse

    // アドレス型
    address public myAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address payable public payableAddress; // ETHを受け取れるアドレス

    // バイト型
    bytes32 public myBytes = "Hello"; // 固定長バイト
    bytes public dynamicBytes; // 可変長バイト

    // 配列
    uint256[] public numbers; // 動的配列
    uint256[5] public fixedNumbers; // 固定長配列（5要素）

    // マッピング（キーバリューストア）
    mapping(address => uint256) public balances; // アドレスからuint256へのマッピング

    constructor() {
        // 配列の初期化例
        numbers.push(1);
        numbers.push(2);
        numbers.push(3);

        // 固定長配列の設定
        fixedNumbers[0] = 10;
        fixedNumbers[1] = 20;

        // マッピングの設定
        balances[msg.sender] = 1000;
    }

    // 状態変数の更新関数の例
    function updateVariables(
        uint256 _number,
        string memory _string,
        bool _bool
    ) public {
        myNumber = _number;
        myString = _string;
        myBool = _bool;
    }

    // 配列操作の例
    function addNumber(uint256 _number) public {
        numbers.push(_number);
    }

    // マッピング操作の例
    function setBalance(address _address, uint256 _balance) public {
        balances[_address] = _balance;
    }
}
