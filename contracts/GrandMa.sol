// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract GrandmaGifts {
    address public grandma;
    uint public totalGift;
    bool public isConfigured;

    struct Grandchild {
        uint birthdate; // timestamp (in seconds)
        bool hasClaimed;
    }

    mapping(address => Grandchild) public grandchildren;
    address[] public grandchildList;

    constructor() {
        grandma = msg.sender;
    }

    // бабуся вносить ETH і вказує список онуків з датами
    function setupGifts(address[] memory _grandchildren, uint[] memory _birthdates) external payable {
        require(msg.sender == grandma, "Only grandma can set this up");
        require(!isConfigured, "Gifts already configured");
        require(_grandchildren.length == _birthdates.length, "Mismatched input lengths");
        require(_grandchildren.length > 0, "At least one grandchild required");
        require(msg.value > 0, "Must send ETH");

        totalGift = msg.value;
        isConfigured = true;

        for (uint i = 0; i < _grandchildren.length; i++) {
            address child = _grandchildren[i];
            grandchildren[child] = Grandchild({
                birthdate: _birthdates[i],
                hasClaimed: false
            });
            grandchildList.push(child);
        }
    }

    // кожен онук викликає цю функцію, щоб отримати подарунок
    function claimGift() external {
        require(isConfigured, "Not yet configured");
        Grandchild storage g = grandchildren[msg.sender];
        require(g.birthdate != 0, "You are not a grandchild");
        require(!g.hasClaimed, "Gift already claimed");
        require(block.timestamp >= g.birthdate, "Too early to claim");

        g.hasClaimed = true;

        uint share = totalGift / grandchildList.length;
        payTo(payable(msg.sender), share); 
    }

    function getMyBirthdate() external view returns (uint) {
        return grandchildren[msg.sender].birthdate;
    }

    function getGrandchildCount() external view returns (uint) {
        return grandchildList.length;
    }

    function payTo(address payable recipient, uint amount) public payable {
    require(address(this).balance >= amount, "Not enough balance in contract");
    recipient.transfer(amount);
    }
}