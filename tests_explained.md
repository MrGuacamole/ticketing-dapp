# Tests Explained
I wrote 8 tests for my ticketing smart contract. They are explained below.

## Test Tickets Remaining
This tests whether the correct amount of tickets are remaining after the contract is deployed. It is important to ensure that the contract
begins with some amount of tickets to purchase.

## Test Breaker
This tests if the circuit breaker is initally inactive. This ensures that the contract is in the right state on creation and tickets 
can be purchased.

## Test Ticket Price
The tests that the initial ticket price is the set to the amount specified. For the contract to be fully functional it is required that
the tickets have a value.

## Test Account Balance
This tests that the account balance is updated after a customer purchases a ticket. I created this test to ensure that the
customer balances are updated correctly.

## Test Ticket Owner
This tests if the owner of the ticket is set after a ticket is purchased. This is important because without the correct owner, many
functions performed involving the ticket will fail.

## Test Ticket For Sale
This tests if the sale status of the ticket is updated properly. Without enabling tickets to be set to 'For Sale', tickets could only be
purchased from the vendor. Setting their status to 'For Sale' provides another point for customers to purchase tickets and lets owners
have more control over how their tickets behave.

## Test Purchasing Tickets From
This tests whether the owner of the ticket and the balance of each participant is correctly updated when purchasing a ticket from another
customer. This is important because if the owner of the ticket was not updated the original owner could perform actions on the ticket even
after receiving payment. Updating the ticket owner and each customers balance ensures that continuity is maintained.

## Test Burning Tickets
This tests that the remaining tickets is updated correctly after burning them. This is necessary as it confirms that the admin has the
ability to remove tickets from the total supply and that the correct amount is removed.



