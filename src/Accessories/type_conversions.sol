//SPDX-License-Identifier: GPL-3.0
pragma solidity ^ 0.8.0;
contract type_conversions{
    // function to convert uint to string->
    function uint_to_string(uint256 _no) internal pure  returns (string memory)
    {
           if(_no==0)
           {
            return '0';
           }
        uint256 temp=_no;
        uint8 digits;

        // finding the no of digits in a no->
        while(temp != 0)
        {
            digits++;
           temp= temp / 10;
        }
        
        // creating a bytes array of size digits->
        bytes memory buffer = new bytes(digits);
        temp=_no;
        uint8 index= digits;

        while(temp!= 0)
        {
                index--;
               uint8 inter=uint8(48+(temp % 10));
           buffer[index]= bytes1(inter);
           temp=temp /10;
        }
        return string(buffer);       
    }
}