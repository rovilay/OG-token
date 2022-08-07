// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

library SafeMath {
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);

        return a - b;
    }
  
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;

        assert(c >= a);

        return c;
    }

}


contract OGERC20 {
    using SafeMath for uint256;

    string _tokenName;
    string _tokenSymbol;
    uint8 _decimal = 18;

    // token balance of each address/account
    mapping(address => uint256) balances;
    
    // address/account with their respecitive approved amount to withdraw
    mapping(address => mapping(address => uint256)) allowed;

    // total supply of token
    uint256 _totalSupply;

    constructor(uint256 total, string memory tokenName, string memory tokenSymbol) {
        _totalSupply = total;
        balances[msg.sender] = _totalSupply;

        _tokenName = tokenName;
        _tokenSymbol = tokenSymbol;
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    function name() public view returns (string memory) {
        return _tokenName;
    }

    function symbol() public view returns (string memory) {
        return _tokenSymbol;
    }

    function decimals() public view returns (uint8) {
        return _decimal;
    }



    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address _tokenAcct) public view returns (uint256 balance) {
        return balances[_tokenAcct];
    }


    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balances[msg.sender] >= _value, "Insufficient balance");

        balances[msg.sender] = balances[msg.sender].sub(_value);

        balances[_to] = balances[_to].add(_value);

        emit Transfer(msg.sender, _to, _value);

        return true;
    }


    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        // confirm approval
        require(allowed[_from][msg.sender] >= _value, "Not approved to transfer this token amount");

        // confirm balance
        require(balances[_from] >= _value, "Insufficient balance");

        balances[_from] = balances[_from].sub(_value);

        // update allowance
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);

        balances[_to] = balances[_to].add(_value);

        emit Transfer(_from, _to, _value);

        return true;
    }


    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);

        return true;
    }


    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }
}
