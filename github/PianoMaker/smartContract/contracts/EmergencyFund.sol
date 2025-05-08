// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract EmergencyFund {

    address public owner;
    uint public requiredApprovals;
    uint public approvalCount;
    mapping(address => bool) public participants;
    mapping(address => bool) public approvedClaims;

    constructor(uint _requiredApprovals) {
        owner = msg.sender;
        requiredApprovals = _requiredApprovals;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can do this");
        _;
    }

    modifier onlyParticipant() {
        require(participants[msg.sender], "Only participants allowed");
        _;
    }

    function addParticipant(address participant) public onlyOwner {
        participants[participant] = true;
    }

    function contribute() public payable onlyParticipant {
        require(msg.value > 0, "Must send some ETH");
    }

    function approveClaim(address claimant) public onlyParticipant {
        approvedClaims[claimant] = true;
        approvalCount++;
    }

    function withdrawFunds(address payable recipient, uint amount) public onlyOwner {
        require(approvedClaims[recipient], "Claim not approved");
        require(approvalCount >= requiredApprovals, "Not enough approvals");
        require(amount <= address(this).balance, "Not enough balance");

        recipient.transfer(amount);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
