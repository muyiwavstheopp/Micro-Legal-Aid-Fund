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

 
    function donate(string calldata _name) external payable {
        require(msg.value > 0, "Donation must be greater than 0");

    
        donors[msg.sender].amount += msg.value;
        donors[msg.sender].name = _name;

        emit DonationReceived(msg.sender, _name, msg.value);
    }

    
    function withdraw(uint _amount) external {
        require(msg.sender == legalAidWallet, "Not authorized");
        require(address(this).balance >= _amount, "Insufficient funds");
        payable(legalAidWallet).transfer(_amount);
        emit FundsWithdrawn(msg.sender, _amount);
    }

   
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

   
    function getDonor(address _donor) external view returns (string memory, uint) {
        Donor memory d = donors[_donor];
        return (d.name, d.amount);
    }    

}
