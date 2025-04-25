// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    
    struct Candidate {
        string name;       
        uint256 voteCount; 
    }


    Candidate[] public candidates;


    address[] public voters;


    function addCandidate(string memory name) public {
        candidates.push(Candidate(name, 0));
    }

    function vote(uint256 candidateIndex) public {

        // Перевіряємо, чи голосував вже цей користувач
        for (uint256 i = 0; i < voters.length; i++) {
            if (voters[i] == msg.sender) {
                revert("You have already voted.");
            }
        }


        require(candidateIndex < candidates.length, "Invalid candidate.");


        candidates[candidateIndex].voteCount++;


        voters.push(msg.sender);
    }


    function getResults() public view returns (Candidate[] memory) {
        return candidates;
    }
}
