// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }

    function _msgValue() internal view virtual returns (uint256 value) {
        return msg.value;
    }
}
