// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SafeCharity {
    address public owner;
    uint256 public balance;

    constructor() {
        owner = msg.sender;
        balance = 0;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function deposit() public payable {
        balance += msg.value;
    }

    function withdraw(uint256 amount) public onlyOwner {
        require(balance >= amount, "Insufficient balance");
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
        balance -= amount;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
