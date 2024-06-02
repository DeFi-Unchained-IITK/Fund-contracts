// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// The receive and fallback functions are called when there is a transaction to the contract (without any call to a payable function).
// If there is call data in the transaction, that requires fallback function to be present.

contract Example{

    uint public result;

    receive() external payable{
        result = 1;
    }


    fallback() external payable{
        result = 2;
    }
}