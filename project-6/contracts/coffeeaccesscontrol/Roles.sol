pragma solidity ^0.4.24;

/**
 * @title Roles
 * @dev Library for managing addresses assigned to a Role.
 */
library Roles {
  struct Role {
    mapping (address => bool) bearer; // mapping address to boolean that assigns a role to an address
  }

  /**
   * @dev give an account access to this role
   */
  function add(Role storage role, address account) internal {

    require(account != address(0)); // checks address introduced is different from the zero address (?)
    require(!has(role, account)); // checks address introduced is not present in the Role mapping

    role.bearer[account] = true; // asigns true to address to role mapping
  }

  /**
   * @dev remove an account's access to this role
   */
  function remove(Role storage role, address account) internal {

    require(account != address(0)); // checks address introduced is different from zero address
    require(has(role, account)); // checks address introduced is present in the Role mapping

    role.bearer[account] = false; // // assigns false to address to role mapping
  }

  /**
   * @dev check if an account has this role
   * @return bool
   */
  function has(Role storage role, address account)
    internal
    view
    returns (bool)
  {
    require(account != address(0)); // checks address introduced is different from zero address
    return role.bearer[account]; // returns address to role mapping
  }
}