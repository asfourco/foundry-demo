// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/SimpleStorage.sol";

contract SimpleStorageTest is DSTest {
    SimpleStorage simple_storage;

    function setUp() public {
        simple_storage = new SimpleStorage();
    }

    function testInitiation() public {
        assertEq(simple_storage.retrieve(), 0);
    }

    function testAddingValue() public {
        simple_storage.store(15);
        assertEq(simple_storage.retrieve(), 15);
    }

    function testNotAContributor() public {
        assertTrue(!simple_storage.isContributor(msg.sender));
    }

    function testAddContribution() public {
        simple_storage.addContribution(msg.sender, 100);
        
        assertTrue(simple_storage.isContributor(msg.sender));
        assertEq(simple_storage.getContribution(msg.sender), 100);
    }

    function testUpdateContribution() public {
        assertTrue(!simple_storage.isContributor(msg.sender));
        simple_storage.addContribution(msg.sender, 100);
        assertTrue(simple_storage.isContributor(msg.sender));
        assertEq(simple_storage.getContribution(msg.sender), 100);
        simple_storage.updateContribution(msg.sender, 200);
        assertEq(simple_storage.getContribution(msg.sender), 200);
    }
}
