// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std/Script.sol";
import "../src/SimpleEscrow.sol";

contract DeployMicroLegalAidFund is Script {
    function run() external {
        vm.startBroadcast();

        // replace with your own wallet address
        new MicroLegalAidFund(0xeB07648f0f1C390bB836bE8598d43d3DfFa5258a);

        vm.stopBroadcast();
    }
}
