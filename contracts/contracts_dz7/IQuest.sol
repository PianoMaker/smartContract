// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

interface IQuest {
    function startQuest(address player) external;
    function completeQuest(address player) external;
    function getReward(address player) external view returns (uint);
}
