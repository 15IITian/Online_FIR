pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {FIR_Components} from "../src/Main/FIR_Components.sol";
import {FIR} from "../src/Main/FIR.sol";
import {DeployScript} from "../script/Counter.s.sol";
import {Police_Station} from "../src/Main/Police_Station.sol";
import {type_conversions} from "../src/Accessories/type_conversions.sol";
import "./Harness/FIR_Harness.sol";

contract Test_FIR is Test, FIR_Harness {
    FIR public f;
    Police_Station public ps;
    DeployScript public deployer;
    address Person1 = vm.addr(1);

    address Person2 = vm.addr(2);

    function setUp() external {
        // (ps, f) = deployer.run();
        ps = new Police_Station();
        f = new FIR(address(ps));

        vm.deal(Person1, 1 ether);
        vm.deal(Person2, 1 ether);
    }

    function test_constructor() public {
        assertEq(address(f.p()), address(ps));
    }

    function test_generate_fir_no() public {
        string memory fir = ext_Generate_FIR_NO();
        assertEq(fir, "001-1");
    }
}
