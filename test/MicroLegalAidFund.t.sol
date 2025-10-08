// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import "../src/SimpleEscrow.sol";

contract MicroLegalAidFundTest is Test {
    MicroLegalAidFund fund;
    address donor = address(0xBEEF);
    address legalAid = address(0xCAFE);

    function setUp() public {
        fund = new MicroLegalAidFund(legalAid);
    }

    function testDonation() public {
        vm.deal(donor, 1 ether);
        vm.prank(donor);
        fund.donate{value: 0.5 ether}("Alice");
        assertEq(fund.getBalance(), 0.5 ether);
    }

    function testWithdraw() public {
        vm.deal(donor, 1 ether);
        vm.prank(donor);
        fund.donate{value: 1 ether}("Alice");

        vm.prank(legalAid);
        fund.withdraw(0.5 ether);
        assertEq(fund.getBalance(), 0.5 ether);
    }
}
