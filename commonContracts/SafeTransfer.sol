pragma solidity ^0.7.0;

library SafeTransfer {

    /**
    *	Requires that address != address(0)
    */

    modifier addressIsNotZero(address inputAddress) {
    	require(
    		inputAddress != address(0),
    		"ERC20: cannot use zero address"
    		);
    	_;
    }

    modifier requireBothAddressesNotZero(address firstInputAddress, address secondInputAddress) {
    	require(
    		firstInputAddress != address(0),
    		"ERC20: cannot use zero address"
    		);

    	require(
    		secondInputAddress != address(0),
    		"ERC20: cannot use zero address"
    		);
    	_;
    }

      /**
    *	Requires that address != address(0x0)
    */
        modifier XaddressIsNotZero(address inputAddress) {
    	require(
    		inputAddress != address(0x0),
    		"ERC20: cannot use zero address"
    		);
    	_;
    }

    modifier XrequireBothAddressesNotZero(address firstInputAddress, address secondInputAddress) {
    	require(
    		firstInputAddress != address(0x0),
    		"ERC20: cannot use zero address"
    		);

    	require(
    		secondInputAddress != address(0x0),
    		"ERC20: cannot use zero address"
    		);
    	_;
    }
}