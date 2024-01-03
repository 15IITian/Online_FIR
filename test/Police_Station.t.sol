pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {FIR_Components} from "../src/Main/FIR_Components.sol";
import {FIR} from "../src/Main/FIR.sol";
import {DeployScript} from "../script/Counter.s.sol";
import {Police_Station} from "../src/Main/Police_Station.sol";
import {type_conversions} from "../src/Accessories/type_conversions.sol";
import "../test/Harness/Police_Station_Harness.sol";

contract Test_Police_Station is Test, FIR_Components {
    FIR public f;
    Police_Station public ps;
    FIR public fir;
    Police_Station_Harness ph;
    Police_Station public police;
    DeployScript public deployer;
    address Person1 = vm.addr(1);

    address Person2 = vm.addr(2);

    function setUp() external {
        // (ps, f) = deployer.run();
        ps = new Police_Station();
        f = new FIR(address(ps));
        ph = new Police_Station_Harness(address(ps));

        vm.deal(Person1, 1 ether);
        vm.deal(Person2, 1 ether);
    }

    function create_fir(uint256 fees) public returns (bool) {
        bool fir_created = true;

        vm.startPrank(Person1);
        if (fees < 1000) {
            vm.expectRevert("Need to send more money to file FIR");
            fir_created = false;
        }

        (bool callSuccess, bytes memory data) = address(f).call{value: fees}(
            abi.encodeWithSignature(
                "FIR_whole_process(string,string,uint256,string,string,string,string,string)",
                "Divyansh",
                "8502077614",
                111234,
                "Jaipur",
                "Phone Snatching",
                "20-09-2023",
                "3:00 AM",
                "Jenil"
            )
        );
        require(callSuccess, "Call failed");
        return fir_created;
        vm.stopPrank();
    }

    // function test_constructor() public {
    //     // assertEq(1,1);
    //     assertEq(ps.StationID(), "001");
    //     assertEq(ps.Address(), "Lucknow");
    //     assertEq(ps.get_Total_FIR(), 0);
    //     assertEq(ps.FIR_remaining(), 0);
    // }

    // function test_terminate_FIR() public {
    //     create_fir(1000);
    //     uint256 prev = ps.FIR_remaining();
    //     ph.ext_terminate_FIR("001-1");
    //     assertEq(prev - 1, ps.FIR_remaining()); // error
    // }

    // function test_Getting_FIR_Report() public {
    //     create_fir(1000);
    //     FIR_Report memory report = ps.Getting_FIR_Report("001-1");
    // }

    function test_Adding_Progress() public {
        create_fir(1000);
        vm.startPrank(Person1);
        FIR_Report memory report = f.FIR_copy();
        // string[] memory arr= ps.FIR_Progress("001-1");
        // uint256 prev= arr.length;
        ps.Adding_Progress("001-1", "Thief caught");
        assertEq()
        vm.stopPrank();
    }
}
