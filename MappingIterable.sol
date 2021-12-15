// SPDX-License-Identifier: GPL-3.0


pragma solidity ^0.8.0;
/**
    @author Pedro Machado
    @notice An abstract contract to work with mapping iterable from easy way
 */

abstract contract MappingIterable {
    
    struct itMap {
        bool exist;
        uint length;
        mapping(uint => uint) valueStoraged;
    }

    mapping(uint => itMap) itMappings;
    uint public totalItMaps;

    modifier isExist(uint indexItMap) {
        require(itMappings[indexItMap].exist, "itMaps doesn't exist.");
        _;
    }

    modifier indexExist(uint _indexItMap, uint _index) {
        require(itMappings[_indexItMap].valueStoraged[_index] != 0x00, "Index exceeds length");
        _;
    }

    function createItMap() public returns(uint index) {
        itMappings[totalItMaps++].exist = true;
        return totalItMaps;
    } 

    function deleteItMap(uint indexItMap) internal isExist(indexItMap) returns(bool) {
        itMappings[indexItMap].exist = false;
        delete itMappings[indexItMap];
        return true;
    }

    function inserElement(uint indexItMap, uint value) internal isExist(indexItMap) returns(uint) {
        itMappings[indexItMap].length++;
        itMappings[indexItMap].valueStoraged[itMappings[indexItMap].length - 1] = value;
        return itMappings[indexItMap].length;        
    }

    function removeElementByIndex(uint indexItMap, uint index) internal isExist(indexItMap) indexExist(indexItMap, index) returns(bool) {
        delete itMappings[indexItMap].valueStoraged[index];
        return true;
    }

    function getItMapsLength(uint indexItMap) view public isExist(indexItMap) returns(uint) {
        return itMappings[indexItMap].length;
    } 

    function returnElementByIndex(uint indexItMap, uint index) view public isExist(indexItMap) indexExist(indexItMap, index) returns(uint) {
        return itMappings[indexItMap].valueStoraged[index];
    }

}


