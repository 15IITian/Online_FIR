//SPDX-License-Identifier: GPL-3.0

// Here defining the police Station institute.

pragma solidity ^0.8.0;
import "./FIR_Components.sol";
pragma experimental ABIEncoderV2;

contract Police_Station is FIR_Components {
    // ---------------------------------------------------------------------------------------------
    // {a} Defining a Police Sation ->

    // ID of each Station ->
    string public StationID;

    // Address of Police_Station
    string public Address;

    // adding person indentity to station person'record
    info_FIR_maker[] person_array;

    // mapping  -> Each FIR report is identified to its FIR'no in Police Station
    mapping(string => FIR_Report) maker_to_Report;

    // variable to store total no of FIR's in that station
    uint256 Total_FIR;

    // no of FIR's remaining ->
    uint256 public FIR_remaining;

    // array kepping records of a FIR->
    mapping(string => string[]) public FIR_Progress;

    // ----------------------------------------------------------------------------------------------------------------------------------------

    // {b} Constructor->
    constructor() {
        StationID = "001";
        Address = "Lucknow";
        Total_FIR = 0;
        FIR_remaining = 0;
    }

    // ---------------------------------------------------------------------------------------------------------------------------------------------------------

    // {c} Defining all Events->
    event NewTransaction(
        address indexed from,
        address indexed to,
        uint256 amount
    );
    // [1]->
    event FIR_Termination(string _FIR_NO, uint256 duration);

    // [2]->
    event Feedback_Given(string _FIR_NO, string work);

    // ------------------------------------------------------------------------------------------------------------------ ----------------------------------------------- ---------------------------------------------------------------------

    // {d} Methods of a Police Station->

    // function to operate internal functions->
    // [i] person_array->
    function get_person_array_element(
        uint256 i
    ) external view returns (info_FIR_maker memory) {
        return person_array[i];
    }

    function add_person_array(info_FIR_maker memory info) external {
        person_array.push(info);
    }

    function get_person_array_len() public view returns (uint256) {
        return person_array.length;
    }

    // [ii] Total FIR->
    function get_Total_FIR() external view returns (uint256) {
        return (Total_FIR);
    }

    function inc_Total_FIR() external {
        Total_FIR++;
    }

    // [iii] maker_to_report->
    function add_maker_to_Report(
        string memory fir_no,
        FIR_Report memory report
    ) external {
        maker_to_Report[fir_no] = report;
    }

    function get_maker_to_Report_element(
        string memory fir_no
    ) external view returns (FIR_Report memory) {
        return maker_to_Report[fir_no];
    }

    //[iv] FIR_remaining->
    function inc_fir_remaining() external {
        FIR_remaining++;
    }

    // [v] FIR_Progress
    function get_FIR_Progress(string memory fir_no)external view returns(string[] memory){
       return FIR_Progress[fir_no];
    } 

    //--------------------------------------------------------------------------------------------------------------

    // Terminating resolved'FIR ->
    function terminate_FIR(string memory FIR_no) public {
        // Acessing Station  from given ID->
        maker_to_Report[FIR_no].settled = true;

        FIR_remaining--;

        // Finding duration of working of FIR->
        uint256 duration = (FIR_Progress[FIR_no]).length * 2;

        // emitting termination event ->
        emit FIR_Termination(FIR_no, duration);
    }

    // showing each FIR to public ->
    function Getting_FIR_Report(
        string memory FIR_no
    ) public view returns (FIR_Report memory) {
        // Acessing Station from ID->
        return maker_to_Report[FIR_no];
    }

    // Adding Progress to a FIR->
    function Adding_Progress(
        string memory _FIR_NO,
        string memory _work
    ) public {
        // First Checking weather That FIR is settled or not->
        bool status = (Getting_FIR_Report(_FIR_NO)).settled;
        require(status == false, "You can't update resolved FIR");

        // Adding work to trackrecord array->
        (FIR_Progress[_FIR_NO]).push(_work);

        // emiting  Feedback event ->
        emit Feedback_Given(_FIR_NO, _work);
    }

    // --------------------------------------------------------------------------------------------------------------------------------------------------------------
}

//_______________________________________________----END----- ________________________________________________________________________________________________
