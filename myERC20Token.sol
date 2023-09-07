// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.12;

contract MyToken {
    string _name; // Token Name
    string _symbol; // Token Symbol
    uint constant DECIMAL = 18; // Token decimal
    uint _totalSupply; // Total Supply of Token to be in circulation

    mapping(address => uint) _balance;
    mapping(address => mapping(address => uint)) _allowance;

    event Transfer(address from, address to, uint value);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );
    event Minted(address to, uint value);

    constructor(string memory name_, string memory symbol_) {
        // Initializing the name and symbol upon deploynment
        _name = name_;
        _symbol = symbol_;
    }

    // ERC20 Token standard functions
    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public pure returns (uint) {
        return DECIMAL;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return _balance[_owner];
    }

    // This code block contains logic that manages the transfer of token
    function transfer(
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(_to != address(0), "Cannot transfer to zero address");
        require(_value > 0, "Cannot send zero ether");
        require(balanceOf(msg.sender) > _value, "Not enough balance");
        _balance[msg.sender] -= _value;
        _balance[_to] += _value;
        success = true;
        emit Transfer(msg.sender, _to, _value);
    }

    // This code block contains logic that allows for the use of this token by other DApps. It gives allowance to the DApp to spend the token.
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(_to != address(0), "Cannot give allowance to zero address");
        require(_value > 0, "Add to allowance");
        require(allowance(_from, _to) >= _value, "Not enough allowance");
        _allowance[_from][_to] -= _value;
        _balance[_from] -= _value;
        success = true;
        emit Transfer(_from, _to, _value);
    }

    // This code block sets the owner and spender to be allowed, it returns the balance allowed to the spender
    function allowance(
        address _owner,
        address _spender
    ) public view returns (uint256 remaining) {
        return _allowance[_owner][_spender];
    }

    // This code block approves the allowance by initializing the value to the balance of the set addresses
    function approve(
        address _spender,
        uint256 _value
    ) public returns (bool success) {
        _allowance[msg.sender][_spender] = _value;
        success = true;
        emit Approval(msg.sender, _spender, _value);
    }

    // This code block mints tokens to the contract address generated after deployment and adds minted tokens to the supply in circulation
    function mint(address _to, uint value) external {
        require(_to != address(0), "Cannot mint to zero address");
        _totalSupply += value;
        _balance[_to] += value;
        emit Minted(_to, value);
    }

    // This code block allows anyone to burn their tokens to address any subtract 90% of the burnt Amount from the total supply and adds 10% to address any
    function burn(address _any, uint value) external {
        require(balanceOf(msg.sender) >= value, "insufficient funds");
        uint amount = value;
        uint burnAmount = (amount * 90) / 100;
        _balance[msg.sender] -= value;
        _totalSupply -= burnAmount;
        _balance[_any] += value - burnAmount; // transfer 10% to any
    }
}
