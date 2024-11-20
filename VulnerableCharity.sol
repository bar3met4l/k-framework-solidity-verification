// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VulnerableCharity {
    uint256 public balance;

    constructor() {
        balance = 0; 
    }

    function deposit() public payable {
        balance += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(balance >= amount, "Insufficient balance");
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
        balance -= amount;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
