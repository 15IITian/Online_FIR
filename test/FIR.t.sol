pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {FIR_Components} from "../src/Main/FIR_Components.sol";
import {FIR} from "../src/Main/FIR.sol";
import {DeployScript} from "../script/Counter.s.sol";
import {Police_Station} from "../src/Main/Police_Station.sol";
import {type_conversions} from "../src/Accessories/type_conversions.sol";
import "./Harness/FIR_Harness.sol";

contract Test_FIR is Test, FIR_Components {
    FIR public f;
    Police_Station public ps;
    DeployScript public deployer;
    FIR_Harness public fh;
    address Person1 = vm.addr(1);

    address Person2 = vm.addr(2);

    function setUp() external {
        // (ps, f) = deployer.run();
        ps = new Police_Station();
        f = new FIR(address(ps));
        fh = new FIR_Harness(address(ps));

        vm.deal(Person1, 1 ether);
        vm.deal(Person2, 1 ether);
    }

    function create_fir(uint256 fees) public returns (bool) {
        bool fir_created = true;
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
    }

    // function test_constructor() public {
    //     assertEq(address(f.p()), address(ps));
    // }

    // function test_generate_fir_no() public {
    //     string memory fir = fh.ext_Generate_FIR_NO();
    //     assertEq(fir, "001-1");
    // }

    // function test_person_intro() public {
    //     info_FIR_maker memory info = fh.ext_Person_intro(
    //         "Divyansh",
    //         "1234556778",
    //         87675
    //     );

    //     // assertEq(info.)
    //     assertEq(ps.get_person_array_len(), 1);
    // }

    // function test_Making_FIR() public {
    //     FIR_Report memory report = fh.ext_Making_FIR(
    //         "Jaipur",
    //         " Phone Snatching ",
    //         "20-09-2023",
    //         "3:00 AM",
    //         "Jenil"
    //     );
    //     /////
    //     assertEq(ps.get_Total_FIR(), 1);
    //     assertEq(ps.FIR_remaining(), 1);
    // }
    //  /
    //     //    function test_search_FIR_no() public {

    //     //    }

    function test_FIR_whole_process_fee_limit() public {
        // bool pass;
        vm.startPrank(Person1);
        uint256 value = 999;
        bool pass = create_fir(value);
        assertEq(pass, false);
        console.log("pass -> ", pass);

        value++;
        pass = create_fir(value);
        assertEq(pass, true);
    }

    // (bool callSuccess, bytes memory data) = address(f).call{value: 1000000}(
    //     abi.encodeWithSignature("func1(string,string)", "ABC", "xxxxxxxxxx")
    // );
    // require(callSuccess, "Call failed");
}

/* Divyansh, 8502077614 , 111234, Jaipur, Phone Snatching ,
 20-09-2023,3:00 AM , Jenil */
