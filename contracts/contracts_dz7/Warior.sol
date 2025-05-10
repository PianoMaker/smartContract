// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;
import "@openzeppelin/contracts/utils/Strings.sol";
using Strings for uint;

contract WarriorGuild {
    string public name;
    uint public strength;

    event WarriorCreated(string name, uint strength);

    function create(string memory _name, uint _strength) internal virtual {
        name = _name;
        strength = _strength;
        emit WarriorCreated(_name, _strength);
    }
}

contract Knight is WarriorGuild {
    constructor(string memory _name) {
        create(_name, 10);
    }

    function defend() public view returns (string memory) {
        return string(abi.encodePacked(name, " defends with strength ", strength.toString()));
    }
}

contract Mage is WarriorGuild {
    constructor(string memory _name) {
        create(_name, 12);
    }
        function conjure() public view returns (string memory) {
        return string(abi.encodePacked(name, " conjures with strength ", strength.toString()));
    }
}

contract Assassin is WarriorGuild {
    constructor(string memory _name) {
        create(_name, 8);
    }
            function attack() public view returns (string memory) {
        return string(abi.encodePacked(name, " attacks with strength ", strength.toString()));
}
}
