// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract EducationGrantFund {

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    struct Student {
        uint deposit;
        bool goalAchieved;
        bool hasWithdrawn;
    }

    mapping(address => Student) public students;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not contract owner");
        _;
    }

    function deposit() external payable {
        require(msg.value > 0, "Must send some ETH");

        students[msg.sender].deposit += msg.value;
    }

    function confirmGoal(address studentAddress) external onlyOwner {
        require(students[studentAddress].deposit > 0, "No deposit for student");

        students[studentAddress].goalAchieved = true;
    }

    function withdrawGrant() external {
        Student storage student = students[msg.sender];

        require(student.goalAchieved, "Goal not achieved yet");
        require(!student.hasWithdrawn, "Grant already withdrawn");
        require(student.deposit > 0, "No deposit available");

        uint amount = student.deposit;
        student.deposit = 0;
        student.hasWithdrawn = true;

        payTo(payable (msg.sender), amount);
    }

        function payTo(address payable recipient, uint amount) public payable {
        require(address(this).balance >= amount, "Not enough balance in contract");
        recipient.transfer(amount);
    }
}
