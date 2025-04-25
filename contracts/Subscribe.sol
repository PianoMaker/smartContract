// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SubscriptionService {
    address public admin;  
    uint256 public subscriptionFee;  
    uint256 public subscriptionPeriod;  


    struct Subscription {
        address user;  
        uint256 expirationTime;  
    }


    Subscription[] public subscriptions;


    event Subscribed(address indexed user, uint256 expirationTime);

    
    constructor(uint256 _subscriptionFee, uint256 _subscriptionPeriod) {
        admin = msg.sender;  
        subscriptionFee = _subscriptionFee;  
        subscriptionPeriod = _subscriptionPeriod;  
    }


    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    
    function subscribe() public payable {
        require(msg.value == subscriptionFee, "Incorrect subscription fee");


        for (uint256 i = 0; i < subscriptions.length; i++) {
            if (subscriptions[i].user == msg.sender) {

                subscriptions[i].expirationTime += subscriptionPeriod;
                emit Subscribed(msg.sender, subscriptions[i].expirationTime);
                return;
            }
        }


        subscriptions.push(Subscription(msg.sender, block.timestamp + subscriptionPeriod));

        emit Subscribed(msg.sender, block.timestamp + subscriptionPeriod);
    }


    function isSubscriptionActive(address user) public view returns (bool) {
        for (uint256 i = 0; i < subscriptions.length; i++) {
            if (subscriptions[i].user == user) {
                return block.timestamp <= subscriptions[i].expirationTime;
            }
        }
        return false;
    }


    function changeSubscriptionFee(uint256 newFee) public onlyAdmin {
        subscriptionFee = newFee;
    }


    function changeSubscriptionPeriod(uint256 newPeriod) public onlyAdmin {
        subscriptionPeriod = newPeriod;
    }


    function withdraw() public onlyAdmin {
        payable(admin).transfer(address(this).balance);
    }


    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
