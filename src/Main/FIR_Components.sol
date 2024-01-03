//SPDX-License-Identifier: GPL-3.0
pragma solidity ^ 0.8.20;
contract FIR_Components{
    // {a} Defining Componenets of FIR->

          // Info about the person who is making FIR
               struct info_FIR_maker{
        
                   string name;
                   address Address;
                   string phone_no;
                   uint256 aadhar_no;
                   string FIR_no;        
               }

          // FIR report
               struct FIR_Report{
                   string FIR_no; 
                   string location_of_incident;
                   string discription;
                   string date;
                   string time;
                   string witness;
                   bool settled;
               }

}
