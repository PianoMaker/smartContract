// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract SampleContract {

    address public owner;
    string str = "Hello world";
    uint[10] public array;

    struct PaymentInfo {
        uint amount;
        string message;
    }

    mapping(address => PaymentInfo) transactions;

    constructor() {
        owner = msg.sender;
    }

    function getPaymentInfo(address accountKey) public view returns (PaymentInfo memory) {
        return transactions[accountKey];
    }

    function getBalance(address account) public view returns (uint256) {
        return account.balance;
    }

    function payTo(uint amount, address payable to) public payable {
        require(msg.value >= amount, "Insufficient funds sent");
        to.transfer(amount);
        transactions[to] = PaymentInfo(amount, "Payment made"); // можна ще повідомлення дати
    }

    function getString() public view returns (string memory) {
        return str;
    }

    function compareString(string memory str1, string memory str2) public pure returns (bool) {
        return keccak256(bytes(str1)) == keccak256(bytes(str2));
    }

    function ifOwner() public view returns (string memory) {
        require(msg.sender == owner, "You're not owner");
        return str;
    }
}
