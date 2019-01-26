# Design Pattern Decisions

## Withdrawl Pattern
One pattern I used was the withdrawl pattern. I implemented this within the refundTicket function.
Tickets are refunded at the value they were originally purchased for because the contract only receives the original purchase value.
This value is then transfered to the owner of the ticket.
By implementing this pattern my contract is able to avoid re-entrancy attacks by setting the refund amount to the original price, 
updating the orignal price to 0 and then transfering the refund amount to the owner.

## Restricting Access
Another pattern I used is restricting access. Functions such as redeeming tickets, adding tickets, burning tickets, 
updating ticket price, killing the contract and more can only be executed by the owner of the contract. 
This prevents anyone with malicous intent from altering important aspects of the contract. 
Access to many state varibles such as ticket pricet, ticket status, remaining tickets and more have also been restricted 
so other contracts cannot read them.

## Mortal Design Pattern
I also implemented the mortal design pattern as I feel since the blockchain is otherwise immutable, it is important to have the 
ability to remove the smart contract from the blockchain. Whether the contract is out of date or it has been comprimised, 
killing the contract is a neccesary step in both of these instances. 

## Circuit Breaker
My contract also includes a circuit breaker which can be activated and inactivated by the contract owner. 
This is necessary to reduce the damage done if the contract is being exploited or to freeze it if a bug is found. 
It also provides a real world implication if the corresponding event has been cancelled as it allows users to refund their tickets.

## State Machine
The changing of the breaker status can also be seen as the contract transitioning into an event cancelled state where the only action
that can be performed on tickets is refunding them.
