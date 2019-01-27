pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Ticketing.sol";

contract TestTicketing {
 // The address of the ticketing contract to be tested
 Ticketing ticketing = Ticketing(DeployedAddresses.Ticketing());
 
 // This tests whether the correct amount of tickets are remaining after the 
 // contract is deployed. It is important to ensure that the contract begins with some amount 
 // of tickets to purchase.
 function testTicketsRemaining() public {
 	 uint expected = 1000;

    Assert.equal(ticketing.remainingTickets(), expected, "Tickets remaining should initially be 1000");
 }
// This tests if the circuit breaker is initally inactive. This ensures that the contract is in the right 
// state on creation and tickets can be purchased.
 function testBreaker() public{
 	bool expected = false;

 	Assert.equal(ticketing.stopExecution(), expected, "Breaker should start inactive");
 } 
}
