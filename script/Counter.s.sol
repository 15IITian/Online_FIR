// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import {Test, console} from "forge-std/Test.sol";
import {Script, console2} from "forge-std/Script.sol";
import "../src/Main/Police_Station.sol";
import "../src/Main/FIR.sol";

contract DeployScript is Script {
    function run() external {
        vm.startBroadcast();
        Police_Station ps = new Police_Station();
        FIR f = new FIR(address(ps));
        console.log("address of ps", address(ps));
        console.log("address of f ", address(f));

        vm.stopBroadcast();
    }
}
