// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

library Math{
    // Не мають змінних стану
    // Можна створювати enum, структури
    function add(uint256 a, uint256 b) pure internal returns(uint){
        return a+b;
    }
    function returnMax(uint a, uint b) pure internal returns(uint){
        return a>b?a:b;
    }
}

// import ./Math.sol

contract SampleContract{

    using Math for uint;

    function sum(uint value) public pure returns(uint){
        return uint(10).add(value);
    }
    function compareValues(uint value1, uint value2) public pure returns(uint){
        return value1.returnMax(value2);
    }
    function useMathWithoutBind(uint value1, uint value2) public pure returns(uint){
        return Math.add(value1, value2);
    }
}

contract LogicContract{
    uint public value;
    address public sender;

    function setValue(uint _value) external payable{
        value = _value;
        sender = msg.sender;
    }
    function getValue() external view returns(uint){
        return value;
    }
}

contract CallerContract{
    
    address otherContract; // slot 0
    uint public value; // slot 1

    constructor(address other){
        otherContract = other;
    }

    function callViaCall(uint sample)external payable returns(bool, bytes memory){
        (bool success, bytes memory data) = otherContract.call{value: msg.value}(
            abi.encodeWithSignature("setValue(uint256)", sample)
        );
        require(success,"Call is not working");
        return (success, data);
    }

    function callViaDelegateCall(uint _value) external payable returns(bool, bytes memory){
        (bool success, bytes memory data) = otherContract.delegatecall(
            abi.encodeWithSignature("setValue(uint256)", _value)
        );
        require(success, "delegate call is not working");
        return (success, data);
    }

    function callViaStaticCall() external view returns(uint){
        (bool success, bytes memory data) = otherContract.staticcall(
            abi.encodeWithSignature("getValue()")
        );
        require(success, "delegate call is not working");
        return abi.decode(data, (uint));
    }
}

contract Parent{
    string internal message = "Parent contract";
    uint private value = 12;

    function getValue()public view returns(uint){
        return value;
    }
    function getFieldsValues() public virtual returns(string memory, uint){
        return(message, value);
    }

}

contract Child is Parent(){

    function setMessage() public{
        message = "Child Contract";
    }

    function getFieldsValues() public override returns(string memory, uint){
        super.getFieldsValues();
        setMessage();
        return(message, getValue());
    }
}

// Abstract contracts
abstract contract Animal{
    function makeSound() public pure virtual returns(string memory);
}

contract Cat is Animal{
    function makeSound() public pure override returns(string memory){
        return "Meow";
    }
}

interface IToken {
    function transfer(address payable _to) external payable returns(bool);
    function balanceOf(address account) external view returns(uint);
}

contract SampleToken is IToken{
    mapping(address => uint) internal balances;

    function transfer(address payable _to) external payable returns(bool){
        _to.transfer(msg.value);
        balances[_to] += msg.value;
        return true;
    }
    function balanceOf(address account) external view returns(uint){
        return balances[account];
    }
}


// 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2

contract UseToken{
    address tokenAddress;

    struct Transfers{
        address account;
        uint amount;
    }

    constructor(address _token){
        tokenAddress = _token;
    }

    function transferTo(address payable _to) public payable returns(Transfers memory){
        // call contract method using interface
        bool result = IToken(tokenAddress).transfer{value: msg.value}(_to);
        require(result, "Transfer failed");
        uint balanceAmount = IToken(tokenAddress).balanceOf(_to);
        return Transfers(
            _to,
            balanceAmount
        );
    }

}