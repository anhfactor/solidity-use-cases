// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

/*
Constants are variables that cannot be modified.

Their value is hard coded and using constants can save gas cost.
*/
contract Constants {
    // coding convention to uppercase constant variables
    address public constant MY_ADDRESS = 0xAb5801a7D398351b8bE11C439e05C5B3259aeC9B;
    uint public constant MY_UINT = 123;
}
