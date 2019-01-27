const Ticketing = artifacts.require("Ticketing");

contract("Ticketing", accounts => {
  const steve = accounts[0];
  const pablo = accounts[2];

  // The tests that the initial ticket price is the set to the amount specified. 
  // For the contract to be fully functional it is required that the tickets have a value.
  it("initial ticket price should be 10000000000000 wei", () =>
    Ticketing.deployed()
      .then(instance => instance.ticketPrice())
      .then(price => {
        assert.equal(
          price.valueOf(),
          100000000000000,
          "100000000000000 wasn't the initial ticket price"
        );
      }));

  // This tests that the account balance is updated after a customer purchases a ticket. 
  // I created this test to ensure that the customer balances are updated correctly.
  it("account balance should be 1", async () => {
    let ticketing = await Ticketing.deployed();
     
    await ticketing.purchaseTickets(1, {from: steve, value:100000000000000} );

      await ticketing.balanceOf.call(steve)
      .then(balance => {
        assert.equal(
          balance.valueOf(),
          1,
          "account balance wasn't 1, check purchase tickets method"
        );
      });
  });

  // This tests if the owner of the ticket is set after a ticket is purchased. 
  // This is important because without the correct owner, many functions performed 
  // involving the ticket will fail.
  it("owner should be steve", async () => {
    let ticketing = await Ticketing.deployed();
    await ticketing.ownerOf.call(1)
    .then(owner => {
      assert.equal(
        owner.valueOf(),
        steve,
        "steve wasn't the owner, check purchase tickets method"
      );
    });
  });

  // This tests if the sale status of the ticket is updated properly. If a tickets sale
  // status was incorrectly set owners would be unable to sell their tickets to other
  // customers, limiting the contract to just one point of purchase.
  it("ticket should be for sale", async () => {
    let ticketing = await Ticketing.deployed();
     
    await ticketing.ticketForSale(steve, 1, true, {from: steve} );

    await ticketing.ticketStatus.call(1)
    .then(status => {
      assert.equal(
        status.valueOf(),
        1,
        "ticket status was not for sale, check ticket for sale method"
      );
    });
  });

  // This tests whether the owner of the ticket and the balance of each participant is 
  // correctly updated when purchasing a ticket from another customer. This is important 
  // because if the owner of the ticket was not updated the original owner could perform 
  // actions on the ticket even after receiving payment. Updating the ticket owner and each 
  // customers balance ensures that continuity is maintained.
  it("owner should be pablo", async () => {
    let ticketing = await Ticketing.deployed();
     
    await ticketing.purchaseTicketsFrom(steve, 1, {from: pablo, value:100000000000000} );

    await ticketing.balanceOf.call(pablo)
    .then(balance => {
      assert.equal(
        balance.valueOf(),
        1,
        "account should have 1 ticket, check purchase tickets from method"
      );
    });
    await ticketing.balanceOf.call(steve)
    .then(balance => {
      assert.equal(
        balance.valueOf(),
        0,
        "account should have 0 tickets, check purchase tickets from method"
      );
    });
    await ticketing.ownerOf.call(1)
    .then(owner => {
      assert.equal(
        owner.valueOf(),
        pablo,
        "pablo wasn't the owner, check purchase tickets from method"
      );
    });
  });

  // This tests that the remaining tickets is updated correctly after burning them. 
  // This is necessary as it confirms that the admin has the ability to remove tickets 
  // from the total supply and that the correct amount is removed.
  it("tickets remaining should be 990", async () => {
    let ticketing = await Ticketing.deployed();
   
    await ticketing.burnTickets(9, {from: steve} );

    await ticketing.remainingTickets.call()
    .then(amount => {
      assert.equal(
        amount.valueOf(),
        990,
        "tickets weren't burned correctly, check burn tickets method"
      );
    });
  });    
});
