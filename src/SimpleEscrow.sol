// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract MicroLegalAidFund {
    address public legalAidWallet;

    struct Donor {
        string name;
        uint amount;
    }

    mapping(address => Donor) public donors;

    event DonationReceived(address indexed donor, string name, uint amount);
    event FundsWithdrawn(address indexed by, uint amount);

    constructor(address _legalAidWallet) {
        legalAidWallet = _legalAidWallet;
    }

    // Function to donate
    function donate(string calldata _name) external payable {
        require(msg.value > 0, "Donation must be greater than 0");

    // Save/update donor record
        donors[msg.sender].amount += msg.value;
        donors[msg.sender].name = _name;

        emit DonationReceived(msg.sender, _name, msg.value);
    }

    // Function to withdraw (only legal aid wallet)
    function withdraw(uint _amount) external {
        require(msg.sender == legalAidWallet, "Not authorized");
        require(address(this).balance >= _amount, "Insufficient funds");
        payable(legalAidWallet).transfer(_amount);
        emit FundsWithdrawn(msg.sender, _amount);
    }

    // Check contract balance
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    // View donor info
    function getDonor(address _donor) external view returns (string memory, uint) {
        Donor memory d = donors[_donor];
        return (d.name, d.amount);
    }    

}