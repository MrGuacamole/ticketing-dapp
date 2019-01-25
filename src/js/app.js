App = {
  web3Provider: null,
  contracts: {},
  account: null,

  init: async function() {

    return await App.initWeb3();
  },

  initWeb3: async function() {
    // Modern dapp browsers...
    if (window.ethereum) {
      App.web3Provider = window.ethereum;
      try {
        // Request account access
        await window.ethereum.enable();
      } catch (error) {
        // User denied account access...
        console.error("User denied account access")
      }
    }
    // Legacy dapp browsers...
    else if (window.web3) {
      App.web3Provider = window.web3.currentProvider;
    }
    // If no injected web3 instance is detected, fall back to Ganache
    else {
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:8545');
    }
    web3 = new Web3(App.web3Provider);

    return App.initContract();
  },

  initContract: function() {

    $.getJSON('Ticketing.json', function(data) {
      // Get the necessary contract artifact file and instantiate it with truffle-contract
      var TicketingArtifact = data;
      App.contracts.Ticketing = TruffleContract(TicketingArtifact);

      // Set the provider for our contract
      App.contracts.Ticketing.setProvider(App.web3Provider);




      // Initialize the User Interface
      return App.initAccount();

    });

    return App.bindEvents();
  },

  initAccount: function(){

      web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }

      console.log(accounts);
      App.account = accounts[0];
      $("#account-address").text(App.account);
      var ether = web3.eth.getBalance(accounts[0]);
      $("#ether-balance").text(ether.toNumber());
      
    });

    return App.initUI();
  },

  initUI: function() {
    $("#operators").addClass("hidden");
    App.updateUI();
  },

  bindEvents: function() {
    $(document).on('click', '#btn-manage-operators', App.manageOperators);
    $(document).on('click', '#btn-purchase-tickets', App.purchaseTickets);
    $(document).on('click', '#btn-ticket-info', App.ticketInfo);
    $(document).on('click', '#btn-ttf', App.transferFrom);
    $(document).on('click', '#btn-is-approved-for-all', App.isApprovedForAll);
    $(document).on('click', '#btn-set-approval-for-all', App.setApprovalForAll);
    $(document).on('click', '#btn-add-tickets', App.addTickets);
    $(document).on('click', '#btn-update-ticket-price', App.updateTicketPrice);
    $(document).on('click', '#btn-burn-tickets', App.burnTickets);
    $(document).on('click', '#btn-burn-tickets-from', App.burnTicketsFrom);
    $(document).on('click', '#btn-for-sale', App.ticketForSale);
    $(document).on('click', '#btn-approve', App.approve);
    $(document).on('click', '#btn-get-approved', App.getApproved);
    $(document).on('click', '.btn-manage-ticket', App.manageTicket);
    $(document).on('click', '#btn-activate-breaker', App.updateBreakerStatus);
    $(document).on('click', '#btn-withdraw-balance', App.withdrawBalance);
    $(document).on('click', '#btn-change-address', App.changeAccount);
    $(document).on('click', '#btn-toggle-testing', App.toggleTesting);
    $(document).on('click', '#btn-refund', App.refundTicket);
  },

  updateUI: function() {
    App.ticketName();
    App.ticketCode();
    App.remainingTickets();
    App.ticketPrice();
    App.balanceOf();
    App.checkOwner();
    App.setTicketGrid();
    App.breakerStatus();
  },

  setTicketGrid: function(){
      // add ticket content section
      $(".ticket-content").remove();
      var content = $("<div></div>").addClass("ticket-content");

      $("#ticket-grid").append(content);
    for (i = 0; i < 20; i++){
            App.ticketGridId(i);
          }
  },

  manageOperators: function() {
    $("#operators").toggleClass("hidden");
  },

  ticketName: function() {
    var ticketingInstance;

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      return ticketingInstance.ticketName.call(); 
    }).then(function(name) {
    $("#ticket-name").text(name);
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  ticketCode: function() {
    var ticketingInstance;

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      return ticketingInstance.ticketCode.call(); 
    }).then(function(code) {
    $("#ticket-code").text(code);
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  ticketPrice: function() {
    var ticketingInstance;

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      return ticketingInstance.ticketPrice.call(); 
    }).then(function(price) {
      $("#ticket-price").text(price);
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  remainingTickets: function() {
    var ticketingInstance;

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      return ticketingInstance.remainingTickets.call(); 
    }).then(function(remainingTickets) {
    $("#remaining-tickets").text(remainingTickets);
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  balanceOf: function() {
    var ticketingInstance;
    var ticketBalance;

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      return ticketingInstance.balanceOf.call(App.account); 
    }).then(function(balance) {
      ticketBalance = balance.toNumber();
      $("#balance").text(ticketBalance);
       }).catch(function(err) {
      console.log(err.message);
    });

  },

  purchaseTickets: function(){
    var ticketingInstance;
    var ticketPrice;
    var totalPrice;

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

     return ticketingInstance.ticketPrice.call(); 
    }).then(function(price) {
      ticketPrice = price.toNumber();
    }).catch(function(err) {
      console.log(err.message);
    });

     var amount = parseInt($("#ticket-amount-purchase").val(), 10);

    setTimeout(function() { App.contracts.Ticketing.deployed().then(function(instance) {
      return ticketingInstance.purchaseTickets(amount, {from: App.account, value: (amount * ticketPrice), gas: 1500000});
    }).then(function(result){
      return App.updateUI();
    }).catch(function(err){
      console.log(err.message);
    });
    }, 1000);
  },

  transferFrom: function(){
    var ticketingInstance;

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      var from = $("#tb-from-address-ttf").val();
      var to = $("#tb-to-address-ttf").val();
      var ticketId = $("#tb-ticket-id-ttf").val();

      return ticketingInstance.transferFrom(from, to, ticketId, {from: App.account, gas: 1500000});
    }).then(function() { 
      return App.updateUI();
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  setApprovalForAll: function(){
    var ticketingInstance;

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      var operator = $("#tb-operator-address").val()
      var value = $("input[name='update-operator']:checked").val();
      var approved = $.parseJSON(value);

      return ticketingInstance.setApprovalForAll(operator, approved, {from: App.account}); 
    }).then(function() {
      $("#operator-update-msg").removeClass("hidden");
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  isApprovedForAll: function(){
    var ticketingInstance;
    var owner;
    var operator;

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      owner = $("#tb-owner-address-iafa").val()
      operator = $("#tb-operator-address-iafa").val();

      return ticketingInstance.isApprovedForAll.call(owner, operator); 
    }).then(function(approved) {
      if (approved == true)
      $("#operator-status").text(operator + " is an approved operator of "
        + owner);
      else if (approved == false){
         $("#operator-status").text(operator + " is NOT an approved operator of "
        + owner);
      }
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  addTickets: function(){
    var ticketingInstance;

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      amount = $("#tb-add-tickets").val()

      return ticketingInstance.addTickets(amount, {from: App.account}); 
    }).then(function() {
      return App.updateUI(); 
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  updateTicketPrice: function(){
    var ticketingInstance;

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      price = $("#tb-ticket-price").val()

      return ticketingInstance.updateTicketPrice(price, {from: App.account}); 
    }).then(function() {
      return App.updateUI(); 
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  burnTickets: function(){
    var ticketingInstance;

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      amount = $("#tb-burn-tickets").val()

      return ticketingInstance.burnTickets(amount, {from: App.account}); 
    }).then(function() {
      return App.updateUI(); 
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  burnTicketsFrom: function(){
    var ticketingInstance;

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      owner = $("#tb-burn-address").val();
      ticketId = $("#tb-ticket-burn-id").val()

      return ticketingInstance.burnTicketsFrom(owner, ticketId, {from: App.account}); 
    }).then(function() {
      return App.updateUI(); 
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  contractBalance: function(){
    var ticketingInstance;

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      return ticketingInstance.contractBalance({from: App.account}); 
    }).then(function(balance) {
      $("#contract-balance").text(balance.toNumber());
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  redeemTicket: function(){
    var ticketingInstance;

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      ticketId = $("#tb-redeem-ticket").val()

      return ticketingInstance.redeemTicket(ticketId, {from: App.account}); 
    }).then(function() {
      return App.updateUI(); 
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  refundTicket: function(){
    var ticketingInstance;

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      var ticketId = parseInt($("#modal-ticket-id").text());

      return ticketingInstance.refundTicket(ticketId, {from: App.account}); 
    }).then(function() {
      return App.updateUI(); 
    }).catch(function(err) {
      console.log(err.message);
    });
  },

    ownerOf: function(){
    var ticketingInstance;
    var ticketId = $("#tb-owner-of").val();
    var status = App.ticketStatus(ticketId);
      
    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      var ticketId = $("#tb-owner-of").val();

      return ticketingInstance.ownerOf.call(ticketId); 
    }).then(function(owner) {
      $("#owner-of-address").parent().removeClass("hidden");
      $("#owner-of-address").addClass("visible");
      $("#owner-of-address").text(owner);
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  ticketGridId: function(i){
    var ticketingInstance;
              var _status;

  App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      return ticketingInstance.ticketIndexLookup.call(App.account, i); 
    }).then(function(id) {

      var _id = id.toNumber()
      if (_id != 0){
      console.log(_id);

      var div = $("<div></div>");
      var ticketId = $("<p></p>").text(_id).addClass("item");
      var ticketStatus = $("<p></p>").addClass("item grid-no" + i);
        $(".ticket-content").append(div);
        $(div).addClass("flex-grid grid" + 1);

        $(div).append(ticketId, ticketStatus);
        App.ticketGridStatus(i, _id, div);
      }
       
    }).catch(function(err) {
      console.log(err.message);
    });
   
  },

  ticketGridStatus: function(i, id, div){
    var ticketingInstance;
    var _status;
    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;
   
      return ticketingInstance.ticketStatus.call(id); 
    }).then(function(status) {
      var id = status.toNumber();
      if (id == 0){
        _status = "Redeemed";
      }
      else if (id == 1){
        _status = "For Sale";
      }
      else {
        _status = "Not For Sale";
      }
       var button = $("<button></button>").text("Manage").
       addClass("item btn btn-primary btn-manage-ticket");

      $(".grid-no" + i).text(_status);
      $(div).append(button);

    }).catch(function(err) {
      console.log(err.message);
    });
  },

  manageTicket: function(){
    var id = parseInt($(this).parent().children().first().text());
    
    $("#myModal").modal('show');
    $("#modal-ticket-id").text(id);

    App.getApproved(id);
  },

  ticketInfo: function(){

    var ticketingInstance;
    var ticketId = $("#tb-owner-of").val();
    var _status;

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      var ticketId = $("#tb-owner-of").val();
      
      return ticketingInstance.ownerOf.call(ticketId); 
    }).then(function(owner) {
      $("#owner-of-address").parent().removeClass("hidden");
      $("#owner-of-address").addClass("visible");
      $("#owner-of-address").text(owner);
    }).catch(function(err) {
      console.log(err.message);
    });

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;
   
      return ticketingInstance.ticketStatus.call(ticketId); 
    }).then(function(status) {
      var id = status.toNumber();
      if (id == 0){
        _status = "Redeemed";
      }
      else if (id == 1){
        _status = "For Sale";
      }
      else {
        _status = "Not For Sale";
      }
      $("#ticket-status").parent().removeClass("hidden");      
      $("#ticket-status").text(_status);

    }).catch(function(err) {
      console.log(err.message);
    });

  },

  changeAccount: function(){
    var account = $("#address").val();
    App.account = account;
    $("#account-address").text(App.account);
      var ether = web3.eth.getBalance(App.account);
      $("#ether-balance").text(ether.toNumber());
    App.updateUI();
  },

  approve: function(){
    var ticketingInstance;
    var ticketId;

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      var approved = $("#tb-approve-address").val();
      ticketId = parseInt($("#modal-ticket-id").text());

      return ticketingInstance.approve(approved, ticketId, {from: App.account}); 
    }).then(function() {
      App.getApproved(ticketId);
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  getApproved: function(ticketId){
    var ticketingInstance;
    

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      return ticketingInstance.getApproved.call(ticketId); 
    }).then(function(address) {
      if (address != "0x0000000000000000000000000000000000000000"){
         $("#tb-approved-result").text("Ticket ID " + ticketId + 
        " has an approved address of " + address);
      }
     else{
      $("#tb-approved-result").text("There is no approved address for this ticket.");
     }
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  ticketForSale: function(){
    var ticketingInstance;

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;
      
      var ticketId = parseInt($("#modal-ticket-id").text());
      var value = $("input[name='for-sale']:checked").val();
      var forSale = $.parseJSON(value);

      return ticketingInstance.ticketForSale(App.account, ticketId, forSale, {from: App.account}); 
    }).then(function() {
      App.updateUI();
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  toggleTesting: function(){
    $("#change-account").toggleClass("hidden");
  },

  checkOwner: function(){
    var ticketingInstance;

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      return ticketingInstance.owner(); 
    }).then(function(owner) {
      if (owner == App.account){
        $("#admin").show();
        $("breaker").show();
        App.contractBalance();
      } 
      else {
        $("#admin").hide();
        $("#breaker").hide();
      }
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  breakerStatus: function(){
    var ticketingInstance;

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      return ticketingInstance.stopExecution(); 
    }).then(function(status) {
      if (status == false){
        $("#breaker-status").text("Breaker is currently Inactive.");
        $(".breaker-false").show();
        $(".breaker-true").hide();

      } 
      else {
        $("#breaker-status").text("Breaker is currently Active.");
        $(".breaker-false").hide();
        $(".breaker-true").show();
      }
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  updateBreakerStatus: function(){
    var ticketingInstance;

    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      var value = $("input[name='activate-breaker']:checked").val();
      var stopExecution = $.parseJSON(value);

      return ticketingInstance.updateBreakerStatus(stopExecution, {from: App.account}); 
    }).then(function() {
      App.breakerStatus();
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  withdrawBalance: function(){
    App.contracts.Ticketing.deployed().then(function(instance) {
      ticketingInstance = instance;

      return ticketingInstance.withdrawBalance({from: App.account}); 
    }).then(function() {
      App.updateUI();
    }).catch(function(err) {
      console.log(err.message);
    });
  }
};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
