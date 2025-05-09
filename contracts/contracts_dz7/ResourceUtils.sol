// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

library ResourceUtils {
    function distributeEnergy(uint total, uint numPlayers) internal pure returns (uint) {
        return total / numPlayers;
    }

    function calculateUpgradeCost(uint level) internal pure returns (uint) {
        return level * 50 + 100;
    }

    function optimizeGoldSpend(uint gold, uint costPerItem) internal pure returns (uint) {
        return gold / costPerItem;
    }
}
