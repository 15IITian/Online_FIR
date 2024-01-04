pragma solidity ^0.8.0;
import "../../src/Main/FIR.sol";

contract FIR_Harness is FIR {
    constructor(address firAddress) FIR(firAddress) {}

    function ext_Generate_FIR_NO() external view returns (string memory) {
        return Generate_FIR_NO();
    }

    function ext_Person_intro(
        string memory _name,
        string memory _phone_no,
        uint256 _aadhar_no
    ) external returns (info_FIR_maker memory) {
        return Person_intro(_name, _phone_no, _aadhar_no);
    }

    function ext_Making_FIR(
        string memory _location_of_incident,
        string memory _discription,
        string memory _date,
        string memory _time,
        string memory _witness
    ) external returns (FIR_Report memory) {
        return
            Making_FIR(
                _location_of_incident,
                _discription,
                _date,
                _time,
                _witness
            );
    }

    function ext_search_FIR_no() external view returns (string memory) {
        return search_FIR_no();
    }
}
