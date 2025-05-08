// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "./ArrayLibrary.sol";

contract ArrayUtils {
    using ArrayLibrary for uint[];

    uint[] public numbers;

    function addNumber(uint value) external {
        numbers.push(value);
    }

    function getIndex(uint value) external view returns (int) {
        return numbers.indexOf(value);
    }

    function sortArray() external {
        numbers.sort();
    }

    function removeAt(uint index) external {
        numbers.remove(index);
    }

    function getAll() external view returns (uint[] memory) {
        return numbers;
    }
}