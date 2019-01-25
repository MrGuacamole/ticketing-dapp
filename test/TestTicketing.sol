pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Ticketing.sol";

contract TestTicketing {
 // The address of the ticketing contract to be tested
 Ticketing ticketing = Ticketing(DeployedAddresses.Ticketing());

 function testTicketsRemaining() public {
 	 uint expected = 1000;

    Assert.equal(ticketing.remainingTickets(), expected, "Tickets remaining should initially be 1000");
 }

 function testBreaker() public{
 	bool expected = false;

 	Assert.equal(ticketing.stopExecution(), expected, "Breaker should start inactive");
 }
 
}