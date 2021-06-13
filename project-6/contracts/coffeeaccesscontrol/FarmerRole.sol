pragma solidity ^0.4.24;

// Import the library 'Roles'
import "./Roles.sol";

// Define a contract 'FarmerRole' to manage this role - add, remove, check
contract FarmerRole {
  using Roles for Roles.Role;                   // alias for roles library created in Roles.sol

  // Define 2 events, one for Adding, and other for Removing
  event FarmerAdded(address indexed account);   // FarmerAdded event accepts an address account and communicates that a farmer has been added. 
                                                // The indexed keyword helps filter the log for this desired data. used in addFarmer function.
  event FarmerRemoved(address indexed account); // FarmerRemoved communicates that a farmer has been removed. used in removeFarmer function.

  // Define a struct 'farmers' by inheriting from 'Roles' library, struct Role
  Roles.Role private farmers;                   // define 'farmers' role from struct Role

  // In the constructor make the address that deploys this contract the 1st farmer
  constructor() public {
    _addFarmer(msg.sender);                     // make the contract deployer the 1st farmer
  }

  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onlyFarmer() {                       // modififers are used to perform checks and only allow the function to run if certain conditions are true.
                                                // in this case, it is outside a specific function to allow for reusability

    require(isFarmer(msg.sender));              // checks role of sender is Farmer
    _;
  }

  // Define a function 'isFarmer' to check this role
  function isFarmer(address account) public view returns (bool) {
    return farmers.has(account);              // check that Farmers struct has/includes the account entered in the function
  }

  // Define a function 'addFarmer' that adds this role
  function addFarmer(address account) public onlyFarmer {
    _addFarmer(account);                      // create a public function with the onlyFarmer modifier that calls an internal add farmer function
  }

  // Define a function 'renounceFarmer' to renounce this role
  function renounceFarmer() public {
    _removeFarmer(msg.sender);                  // create a public function that calls the internal private function that calls an internal private function
  }                                             // removes the farmer role if msg.sender is a Farmer

  // Define an internal function '_addFarmer' to add this role, called by 'addFarmer'
  function _addFarmer(address account) internal {
    farmers.add(account);                       // call the add function from the Roles library (Roles.sol)
    emit FarmerAdded(account);                  // emit message that a farmer was added
  }

  // Define an internal function '_removeFarmer' to remove this role, called by 'removeFarmer'
  function _removeFarmer(address account) internal {
    farmers.remove(account);                    // removes the farmer role from the account presented
    emit FarmerRemoved(account);                // emit message that the account removed its farmer role
  }
}