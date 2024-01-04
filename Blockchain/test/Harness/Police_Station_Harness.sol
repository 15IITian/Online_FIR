pragma solidity ^0.8.0;
import "../../src/Main/FIR.sol";

contract Police_Station_Harness is Police_Station {
    Police_Station ps;

    constructor(address police) {
        ps = Police_Station(police);
    }

    function ext_terminate_FIR(string memory FIR_no) external {
        ps.terminate_FIR(FIR_no);
    }
}
