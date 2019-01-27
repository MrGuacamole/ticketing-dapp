# Avoiding Common Attacks

## Re-entrancy Attacks
To avoid re-entrancy attacks I implemented the withdrawl pattern. This ensures that attackers cannot recieve the value of a ticket more 
than once when they refund it.

## Integer Overflow/Underflow
To avoid the underflow or overflow of integers I utilized the Safe Math library for all mathematic functions. The Safe Math library 
performs unsigned math operations with safety checks that revert on error. This prevents the problems with the overflow or underflow of 
integers from occuring.

## Denial of Service with Block Gas Limit
My contract contains a couple of for loops. One for generating tickets and the other for removing a ticket from the list of owner tickets. 
Both of these loops are bounded via the amount of tickets an individual account can receive which is 20. This prevents the contract from reaching the block gas limit and producing a denial of service.
