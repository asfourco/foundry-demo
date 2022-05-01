// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.13;

contract SimpleStorage {
    uint256 private value;

    struct ContributorStruct {
        uint256 value;
        uint listPointer;
    }

    mapping(address => ContributorStruct) public contributorStructs;
    address[] public contributorList;

    function store(uint256 _value) public {
        value = _value;
    }

    function retrieve() public view returns(uint256) {
        return value;
    }

    function isContributor(address _address) public view returns (bool isIndeed) {
        if (contributorList.length == 0) return false;
        return (contributorList[contributorStructs[_address].listPointer] == _address);
    }

    function addContribution(address _address, uint256 _value) public returns (bool success) {
        require(!isContributor(_address));
        
        contributorList.push(_address);
        contributorStructs[_address].value = _value;
        contributorStructs[_address].listPointer = contributorList.length - 1;
        return true;
    }

    function getContribution(address _address) public view returns(uint256) {
        require(isContributor(_address));
        return contributorStructs[_address].value;
    }

    function updateContribution(address _address, uint256 _value) public returns (bool success) {
        require(isContributor(_address));
        contributorStructs[_address].value = _value;
        return true;
    }
}
