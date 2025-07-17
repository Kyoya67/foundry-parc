// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// まず、シンプルなコントラクトを定義
contract SimpleContract {
    uint256 public value;

    constructor(uint256 _value) {
        value = _value;
    }
}

// テスト用のメインコントラクト
contract VisibilityExample {
    // publicの場合：
    SimpleContract public publicContract; // 誰でもアクセス可能
    // 自動的にgetterが生成される

    // privateの場合：
    SimpleContract private privateContract; // このコントラクト内からのみアクセス可能

    // internalの場合：
    SimpleContract internal internalContract; // このコントラクトと継承先からアクセス可能

    constructor() {
        // コンストラクタでインスタンス化
        publicContract = new SimpleContract(1);
        privateContract = new SimpleContract(2);
        internalContract = new SimpleContract(3);
    }

    // publicContractは自動的にgetterが生成されるため、
    // 外部から publicContract() で値を取得できる

    // privateContractの値を取得するには専用の関数が必要
    function getPrivateContractValue() public view returns (uint256) {
        return privateContract.value();
    }

    // internalContractの値を取得する関数
    function getInternalContractValue() public view returns (uint256) {
        return internalContract.value();
    }
}
