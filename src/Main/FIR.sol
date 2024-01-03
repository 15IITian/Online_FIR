//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
import "./Police_Station.sol";
import "../Accessories/Type_Conversion.sol";

contract FIR is Police_Station, type_conversions {
    // event NewTransaction(address indexed from, address indexed to, uint256 amount);

    //     emit NewTransaction(msg.sender, _to, _amount);

    //______________________________________________________________________________________________________________________________________________________________
    // {a} Events ->
    // [1]->
    event Person_Registration(string _name);

    // [2]->
    event FIR_Drafted(string _FIR_NO);

    // [3]->
    event FIR_process_Completion();

    // {a} Functions related to FIR->
    // [i] Internal Functions->

    //(1) Generating FIR_NO->
    function Generate_FIR_NO() internal view returns (string memory) {
        return (string.concat(StationID, "-", uint_to_string(Total_FIR + 1)));
    }

    //(2) Registering  Person's data->
    function Person_intro(
        string memory _name,
        string memory _phone_no,
        uint256 _aadhar_no
    ) internal returns (info_FIR_maker memory) {
        // Creating  FIR_NO->
        string memory FIR_NO = Generate_FIR_NO();
        info_FIR_maker memory p1 = info_FIR_maker(
            _name,
            msg.sender,
            _phone_no,
            _aadhar_no,
            FIR_NO
        );

        person_array.push(p1);

        // Emitting Event->
        emit Person_Registration(_name);

        return p1;
    }

    //(3) Drafting  FIR->
    function Making_FIR(
        string memory _location_of_incident,
        string memory _discription,
        string memory _date,
        string memory _time,
        string memory _witness
    ) internal returns (FIR_Report memory) {
        // Getting Genearted FIR_NO->
        string memory _FIR_NO = Generate_FIR_NO();

        FIR_Report memory f1 = FIR_Report(
            _FIR_NO,
            _location_of_incident,
            _discription,
            _date,
            _time,
            _witness,
            false
        );
        Total_FIR++;
        FIR_remaining += 1;

        // Emmitting Drafted_FIR event ->
        emit FIR_Drafted(_FIR_NO);

        return f1;
    }

    //(4) searching for FIR_no in info_FIR_maker array ->
    function search_FIR_no() internal view returns (string memory) {
        for (uint256 i = 0; i <= person_array.length; i++) {
            if (person_array[i].Address == msg.sender) {
                return person_array[i].FIR_no;
            }
        }
        return "";
    }

    // [ii] Main Functions ->

    // Registering FIR->
    function FIR_whole_process(
        string memory _name,
        string memory _phone_no,
        uint256 _aadhar_no,
        string memory _location_of_incident,
        string memory _discription,
        string memory _date,
        string memory _time,
        string memory _witness
    ) public payable {
        // have to give money for making FIR->
        require(msg.value >= 1000, "Need to send more money to file FIR");

        // Making record of person_identity->
        info_FIR_maker memory p1 = Person_intro(_name, _phone_no, _aadhar_no);
        // Drafting FIR Report->
        FIR_Report memory f1 = Making_FIR(
            _location_of_incident,
            _discription,
            _date,
            _time,
            _witness
        );

        // Linking a person to it's FIR report->
        maker_to_Report[p1.FIR_no] = f1;

        // Emmitting FIR_process_Completion event ->
        emit FIR_process_Completion();
    }

    function FIR_copy() public view returns (FIR_Report memory) {
        string memory result = search_FIR_no();

        require(bytes(result).length != 0, "You have not filed any FIR");
        return maker_to_Report[result];
    }

    // ___________________________________________--------END------------________________________________________________________________________________________________________________________
}
