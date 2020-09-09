pragma solidity ^0.7.0;

import "../commonContracts/SafeMath.sol";
import "../commonContracts/SafeTransfer.sol";


//SafeTransfer not used yet..

contract ERC20 {
    using SafeMath for uint256;
    //using SafeTransfer for address;

    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    uint8 private _decimals;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor (string memory name, string memory symbol) {
        _name = name;
        _symbol = symbol;
        _decimals = 18;
    }

    /**
     * @dev Returns the name of the token.
     */
    function getName() public view returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function getSymbol() public view returns (string memory) {
        return _symbol;
    }

    function getDecimals() public view returns (uint8) {
        return _decimals;
    }
    function getTotalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function getBalanceOfSpecificAddress(address account) public view returns (uint256) {
        return _balances[account];
    }



    //public exposure of internal functions:

    function transfer(
        address recipient,
        uint256 amount
    ) public returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function allowance(
        address owner,
        address spender
    ) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(
        address spender,
        uint256 amount
    ) public returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender,
            _msgSender(), _allowances[sender][_msgSender()].sub(
                amount,
                "ERC20: transfer amount exceeds allowance"
            )
        );
        return true;
    }

    function increaseAllowance(
        address spender,
        uint256 addedValue
    ) public virtual returns (bool) {
        _approve(
            _msgSender(), spender, _allowances[_msgSender()][spender].add(
                addedValue
            )
        );
        return true;
    }

    function decreaseAllowance(
        address spender,
        uint256 subtractedValue
    ) public virtual returns (bool) {
        _approve(
            _msgSender(), spender, _allowances[_msgSender()][spender].sub(
                subtractedValue,
                "ERC20: decreased allowance below zero"
            )
        );
        return true;
    }


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

    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * Emits a {Transfer} event.
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(address sender, address recipient, uint256 amount) requireBothAddressesNotZero(sender,recipient) internal virtual {

        _balances[sender] = _balances[sender].sub(
            amount,
            "ERC20: transfer amount exceeds balance"
        );

        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     * Requirements:
     *
     * - `to` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) addressIsNotZero(account) internal virtual {

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) XaddressIsNotZero(account) internal virtual {

            _balances[account] = _balances[account].sub(
            amount,
            "ERC20: burn amount exceeds balance"
        );

        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner`s tokens.
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 amount) XrequireBothAddressesNotZero(owner,spender) internal virtual {

         _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
}


contract Token is ERC20 {
	constructor() ERC20("NEWTOKE","NEWTOKE") {
		_mint(msg.sender, 100000000000E18);
	}
}
