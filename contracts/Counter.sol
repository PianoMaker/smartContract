// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter {
    int256 private counter;

    constructor() {
        counter = 0;
    }

    function increment() public {
        counter++;
    }


    function decrement() public {
        counter--;
    }

     function getCounter() public view returns (int256) {
        return counter;
    }
}