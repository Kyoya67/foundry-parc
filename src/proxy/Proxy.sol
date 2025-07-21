// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Proxy {
    // implementation契約のアドレスを格納するスロット
    bytes32 private constant IMPLEMENTATION_SLOT =
        bytes32(uint256(keccak256("eip1967.proxy.implementation")) - 1);

    address public owner;

    constructor(address _implementation) {
        owner = msg.sender;
        _setImplementation(_implementation);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // implementation契約を変更する関数
    function upgrade(address _newImplementation) external onlyOwner {
        _setImplementation(_newImplementation);
    }

    // 現在のimplementation契約のアドレスを取得
    function implementation() external view returns (address) {
        return _getImplementation();
    }

    function _setImplementation(address _implementation) internal {
        require(_implementation != address(0), "Invalid implementation");

        bytes32 slot = IMPLEMENTATION_SLOT;
        assembly {
            sstore(slot, _implementation)
        }
    }

    function _getImplementation() internal view returns (address impl) {
        bytes32 slot = IMPLEMENTATION_SLOT;
        assembly {
            impl := sload(slot)
        }
    }

    // fallback: すべての関数呼び出しをimplementation契約にdelegatecall
    fallback() external payable {
        address impl = _getImplementation();
        assembly {
            // calldataを完全にコピー
            calldatacopy(0, 0, calldatasize())

            // delegatecall実行
            let result := delegatecall(gas(), impl, 0, calldatasize(), 0, 0)

            // 戻り値をコピー
            returndatacopy(0, 0, returndatasize())

            switch result
            case 0 {
                // エラーの場合revert
                revert(0, returndatasize())
            }
            default {
                // 成功の場合return
                return(0, returndatasize())
            }
        }
    }

    receive() external payable {}
}
