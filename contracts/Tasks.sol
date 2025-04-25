// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TaskManager {
    
    string[] private tasks;

    
    function addTask(string memory task) public {
        tasks.push(task);
    }

    
    function removeTask(uint256 index) public {
        require(index < tasks.length, "Task does not exist.");
        
            tasks[index] = tasks[tasks.length - 1];       
    
        tasks.pop();
    }
    
    function getTasks() public view returns (string[] memory) {
        return tasks;
    }
}
