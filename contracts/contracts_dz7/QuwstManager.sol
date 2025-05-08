// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "./IQuest.sol";

contract QuestManager is IQuest {
    struct Quest {
        bool started;
        bool completed;
        uint reward;
        uint level;
    }

    mapping(address => Quest) public quests;

    function startQuest(address player) external override {
        require(!quests[player].started, "Already started");
        quests[player] = Quest(true, false, 100, 1); // Example values
    }

    function completeQuest(address player) external override {
        require(quests[player].started, "Not started");
        require(!quests[player].completed, "Already completed");
        quests[player].completed = true;
        quests[player].reward = quests[player].level * 100;
    }

    function getReward(address player) external view override returns (uint) {
        require(quests[player].completed, "Quest not completed");
        return quests[player].reward;
    }
}
