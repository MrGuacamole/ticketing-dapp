const Ticketing = artifacts.require("Ticketing");

contract("Ticketing", accounts => {
  const steve = accounts[0];
  const pablo = accounts[2];

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