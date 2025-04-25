// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CommunityVoting {
    address public admin; 
    uint256 public totalFunds;

    
    struct Project {
        uint256 id;
        string description;
        uint256 fundingGoal;
        uint256 votes; 
        address proposer;
    }

    
    struct Vote {
        address voter;
        uint256 projectId;
    }


    Project[] public projects;

    Vote[] public votes;

    constructor(uint256 _totalFunds) {
        admin = msg.sender; 
        totalFunds = _totalFunds;
    }


    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    // Функція для пропонування нового проекту
    function proposeProject(string memory _description, uint256 _fundingGoal) public {
        uint256 projectId = projects.length; 
        projects.push(Project(projectId, _description, _fundingGoal, 0, msg.sender)); 
    }

    // Функція для голосування за проект
    function voteForProject(uint256 _projectId) public {
        require(_projectId < projects.length, "Invalid project ID");

        for (uint256 i = 0; i < votes.length; i++) {
            if (votes[i].voter == msg.sender && votes[i].projectId == _projectId) {
                revert("You have already voted for this project");
            }
        }

        votes.push(Vote(msg.sender, _projectId));

        projects[_projectId].votes += 1;
    }

    function fundProjects() public onlyAdmin {
        uint256 totalVotes = 0;

        for (uint256 i = 0; i < projects.length; i++) {
            totalVotes += projects[i].votes;
        }

        for (uint256 i = 0; i < projects.length; i++) {
            Project storage project = projects[i];
            if (project.votes > 0) {
                uint256 fundingAmount = (project.votes * totalFunds) / totalVotes;
                payable(project.proposer).transfer(fundingAmount);
            }
        }
    }

    
    function changeTotalFunds(uint256 _newTotalFunds) public onlyAdmin {
        totalFunds = _newTotalFunds;
    }

    function getProject(uint256 _projectId) public view returns (string memory, uint256, uint256, address) {
        require(_projectId < projects.length, "Invalid project ID");
        Project storage project = projects[_projectId];
        return (project.description, project.fundingGoal, project.votes, project.proposer);
    }


    function getProjectsCount() public view returns (uint256) {
        return projects.length;
    }


    function getVotesCount() public view returns (uint256) {
        return votes.length;
    }
}
