// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// 子コントラクト
contract Child {
    uint256 public value;

    constructor(uint256 _value) {
        value = _value;
    }

    function setValue(uint256 _value) public {
        value = _value;
    }
}

// 親コントラクト
contract Parent {
    // コントラクトを型として使用
    Child public myChild;
    Child[] public children; // コントラクトの配列
    mapping(address => Child) public addressToChild; // マッピングでも使える

    constructor() {
        // newを使って新しいコントラクトインスタンスを作成
        myChild = new Child(100);

        // 配列に追加
        children.push(new Child(1));
        children.push(new Child(2));

        // マッピングに追加
        addressToChild[msg.sender] = new Child(3);
    }

    function createNewChild(uint256 _value) public {
        // 関数内でも新しいコントラクトを作成可能
        Child newChild = new Child(_value);
        children.push(newChild);
    }

    function interactWithChild() public {
        // 子コントラクトのメソッドを呼び出し
        myChild.setValue(200);

        // 配列の子コントラクトとやり取り
        children[0].setValue(10);

        // マッピングの子コントラクトとやり取り
        addressToChild[msg.sender].setValue(30);
    }
}
