pragma solidity ^0.8.20;
import "../../src/Main/FIR.sol";

contract  FIR_Harness is FIR{

    function ext_Generate_FIR_NO() external returns(string memory){
        Generate_FIR_NO();
    }
}
