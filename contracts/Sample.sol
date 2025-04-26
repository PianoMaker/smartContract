// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0 <0.9.0;

contract SampleContract{

string str = "Hello world";

uint[10] public array;



struct PaymentInfo{
    uint amount;
    string message;
}

function getPaymentInfo(address accountKey) public view returns (PaymentInfo memory){
return transactions[accountKey];
}

mapping(address => PaymentInfo) transactions;

function getBalance(address account) public view returns (uint256){
    return account.balance;
}

function payTo (uint amount, address payable to) public payable {
    to.transfer(amount);
}

function getString()
public view returns (string memory) {
        return str;
    }

//порівняння
function compareString(string memory str1, string memory str2) public pure returns (bool) {
    return keccak256(bytes(str1)) == keccak256(bytes(str2))






















 


}
