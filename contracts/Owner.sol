// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Context.sol";

contract Owner is Context {
    address public owner;

    constructor() {
        owner = _msgSender();
    }

    modifier onlyOwner() {
        require(
            owner == _msgSender(),
            "Only contract owner can access this function"
        );
        _;
    }

    function isOwner() internal view returns (bool) {
        return owner == _msgSender();
    }
}
