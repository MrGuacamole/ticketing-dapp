pragma solidity ^0.5.0;

/// @title ERC-721 Non-Fungible Token Standard
/// @dev See https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md
///  Note: the ERC-165 identifier for this interface is 0x80ac58cd
interface ERC721 /* is ERC165 */ {
    /// @dev This emits when ownership of any NFT changes by any mechanism.
    ///  This event emits when NFTs are created (`from` == 0) and destroyed
    ///  (`to` == 0). Exception: during contract creation, any number of NFTs
    ///  may be created and assigned without emitting Transfer. At the time of
    ///  any transfer, the approved address for that NFT (if any) is reset to none.
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

    /// @dev This emits when the approved address for an NFT is changed or
    ///  reaffirmed. The zero address indicates there is no approved address.
    ///  When a Transfer event emits, this also indicates that the approved
    ///  address for that NFT (if any) is reset to none.
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

    /// @dev This emits when an operator is enabled or disabled for an owner.
    ///  The operator can manage all NFTs of the owner.
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero
    function balanceOf(address _owner) external view returns (uint256);

    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT
    function ownerOf(uint256 _tokenId) external view returns (address);

    /// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
    ///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
    ///  THEY MAY BE PERMANENTLY LOST
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    function transferFrom(address _from, address _to, uint256 _tokenId) external payable;

    /// @notice Set or reaffirm the approved address for an NFT
    /// @dev The zero address indicates there is no approved address.
    /// @dev Throws unless `msg.sender` is the current NFT owner, or an authorized
    ///  operator of the current owner.
    /// @param _approved The new approved NFT controller
    /// @param _tokenId The NFT to approve
    function approve(address _approved, uint256 _tokenId) external payable;

    /// @notice Enable or disable approval for a third party ("operator") to manage
    ///  all of `msg.sender`'s assets.
    /// @dev Emits the ApprovalForAll event. The contract MUST allow
    ///  multiple operators per owner.
    /// @param _operator Address to add to the set of authorized operators.
    /// @param _approved True if the operator is approved, false to revoke approval
    function setApprovalForAll(address _operator, bool _approved) external;

    /// @notice Get the approved address for a single NFT
    /// @dev Throws if `_tokenId` is not a valid NFT
    /// @param _tokenId The NFT to find the approved address for
    /// @return The approved address for this NFT, or the zero address if there is none
    function getApproved(uint256 _tokenId) external view returns (address);

    /// @notice Query if an address is an authorized operator for another address
    /// @param _owner The address that owns the NFTs
    /// @param _operator The address that acts on behalf of the owner
    /// @return True if `_operator` is an approved operator for `_owner`, false otherwise
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);
}

/**
 * @title SafeMath
 * @dev Unsigned math operations with safety checks that revert on error
 */
library SafeMath {
    /**
    * @dev Multiplies two unsigned integers, reverts on overflow.
    */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b);

        return c;
    }

    /**
    * @dev Integer division of two unsigned integers truncating the quotient, reverts on division by zero.
    */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
    * @dev Subtracts two unsigned integers, reverts on overflow (i.e. if subtrahend is greater than minuend).
    */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        uint256 c = a - b;

        return c;
    }

    /**
    * @dev Adds two unsigned integers, reverts on overflow.
    */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);

        return c;
    }

    /**
    * @dev Divides two unsigned integers and returns the remainder (unsigned integer modulo),
    * reverts when dividing by zero.
    */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
}
/**
 * @title Owned
 * @dev Keeps track of the contract owner.
 */        
contract Owned {
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address newOwner) onlyOwner public {
        owner = newOwner;
    }
}

/**
 * @title Ticketing
 * @dev Ticketing smart contract for use in ticketing applications.
 */
contract Ticketing is ERC721, Owned{
    
    /// @dev This emits when ownership of any NFT changes by any mechanism.
    ///  This event emits when NFTs are created (`from` == 0) and destroyed
    ///  (`to` == 0). Exception: during contract creation, any number of NFTs 
    ///  may be created and assigned without emitting Transfer. At the time of
    ///  any transfer, the approved address for that NFT (if any) is reset to none.
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

    /// @dev This emits when the approved address for an NFT is changed or
    ///  reaffirmed. The zero address indicates there is no approved address.
    ///  When a Transfer event emits, this also indicates that the approved
    ///  address for that NFT (if any) is reset to none.
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

    /// @dev This emits when an operator is enabled or disabled for an owner.
    ///  The operator can manage all NFTs of the owner.
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
    
    /// @dev This emits when there is an update to the ticket supply
    /// A return of false indicates that the total supply decreased
    event SupplyUpdate(uint256 indexed _amount, bool _increased);
    
     /// @dev This emits a ticket is purchased either from a primary or secondary supplier
    /// A zero address of 'from' indicates that the ticket was generated
    event TicketPurchased(address indexed _from, address indexed _to, uint256 indexed _tokenId, uint256 price);
    
    using SafeMath for uint256;
    
    bool public stopExecution = false;
    
    uint256 totalSupply;
    
    uint256 ticketsRemaining;
    
    uint256 ticketId = 1;
    
    // name of ticket
    string name;

    // ticket code
    string code;
    
    // ticket price in wei
    uint256 price;
    
    // user total tickets purchased
    mapping (address => uint256) ticketsPurchased;
    
    // user ticket balance
    mapping (address => uint256) ticketBalance;
    
    // owner of each ticket
    mapping (uint256 => address) ticketOwners;
    
    // valid ticket id's
    mapping (uint256 => bool) validTicket;
    
    // approved addresses to transfer specific token on owners behalf
    mapping(address => mapping (uint256 => address)) private approvedAddress;
    
    // approved operators to perform tasks on owners behalf
    mapping(address => mapping (address => bool)) private approvedOperator;
    
    // user prices paid for each ticket
    mapping(address => mapping(uint256 => uint256)) private ticketPrices;
    
    // array of ticket ids for each user
    mapping(address => mapping(uint256 => uint256)) private ownerTickets;
    
    mapping (uint256 => Ticket) public tickets;
    
     struct Ticket {
        uint id;
        string name;
        string code;
        Status status;
        uint256 purchasePrice;
        uint256 originalPrice;
    }
    
    enum Status {redeemed, forSale, notForSale}
    
    
    // implement these two
    modifier breakerActive { assert(stopExecution == true); _;}
    
    modifier breakerInactive { assert(stopExecution == false); _;}
    
    modifier pending(uint256 _tokenId) { require(tickets[_tokenId].status != Status.redeemed); _;}
    
    modifier ticketOwner(uint256 _tokenId) {require(ticketOwners[_tokenId] == msg.sender); _;}
    
      constructor(uint256 _initialSupply, uint256 _price, string memory _name, string memory _code) public {
          totalSupply = _initialSupply;
          ticketsRemaining = _initialSupply;
          price = _price; 
          name = _name;
          code = _code;
    }
    
    /** @dev Generates NFTs as tickets.
      * @param _amount Amount of tickets to generate. 
      * @param _owner The owner of the ticket. 
      * @param _price The price of the ticket.
      */
    function generateTicket(uint256 _amount, address _owner, uint256 _price) internal{
        for (uint256 i = 0; i < _amount; i++) {
            ticketOwners[ticketId] = _owner;
            validTicket[ticketId] = true;
            
             // add ticket index
            uint256 index = ticketsPurchased[_owner];
            ownerTickets[_owner][index] = ticketId;
           
            ticketsPurchased[_owner] = ticketsPurchased[_owner].add(1);
            
            //add ticket struct
            tickets[ticketId] = Ticket({ id: ticketId, name: name, code: code, status: Status.notForSale, purchasePrice: _price, originalPrice: _price});
            
            ticketId ++;
            emit TicketPurchased(address(0), _owner, ticketId, _price);
        }
    }
    
    /** @dev Refund the purchaser the amount they overpaid.
      * @param _refundAmount The amount to refund the purchaser.
      */ 
    function refundOverpay(uint256 _refundAmount) internal {
        msg.sender.transfer(_refundAmount);
    }
    
    /** @dev Purchase tickets from the primary vendor. Tickets are
      *  generated at a maximum of 10 per transaction.  
      * @param _amount Amount of tickets to purchase.
      */  
    function purchaseTickets(uint256 _amount) breakerInactive  public payable {
        require(_amount > 0);
        uint256 currentPrice = price;
        uint256 totalPayment = currentPrice.mul(_amount);
        require(totalPayment <= msg.value);
        
        // minimise generation load
        require(_amount <= 10);
        // check enough tickets remaining 
        require(ticketsRemaining >= _amount);
        // check total purchase limit hasn't been reached
        require((ticketsPurchased[msg.sender] + _amount) <= 20);
   
        generateTicket(_amount, msg.sender, currentPrice);
        ticketBalance[msg.sender] = ticketBalance[msg.sender].add(_amount);
        ticketsRemaining = ticketsRemaining.sub(_amount);
        
        uint256 refundAmount = msg.value.sub(totalPayment);
        if (refundAmount > 0){
            refundOverpay(refundAmount);
        }
    }
    
    /** @dev Adds tickets to the total supply, updating the tickets remaining.
      * @param _amount The amount of tickets to add.
      */ 
    function addTickets(uint256 _amount) onlyOwner breakerInactive public {
        totalSupply = totalSupply.add(_amount);
        ticketsRemaining = ticketsRemaining.add(_amount);
        
        emit SupplyUpdate(_amount, true);
    }
    
    /** @dev Updates the price of all tickets
      * @param _price The new price of all tickets
      */ 
    function updateTicketPrice(uint256 _price) onlyOwner breakerInactive public {
        require(_price >= 0);
        price = _price;
    }
    
    /** @dev Remove tickets from the totalSupply and update ticketsRemaining.
      * @param _amount The amount of tickets to remove. 
      */ 
    function burnTickets(uint256 _amount) onlyOwner public {
        // update variables
        totalSupply = totalSupply.sub(_amount);
        ticketsRemaining = ticketsRemaining.sub(_amount);
        
        emit SupplyUpdate(_amount, false);
    }
    
    /** @dev Remove tickets from specified address and update ticketsRemaining. 
      * @param _owner The owner of the ticket.
      * @param _tokenId The id of the ticket.
      */ 
    function burnTicketsFrom(address _owner, uint256 _tokenId) onlyOwner public {
        // owner owns ticket
        require(ticketOwners[_tokenId] == _owner);
        // update variables
        ticketBalance[_owner] = ticketBalance[_owner].sub(1);
        ticketOwners[_tokenId] = address(0);
        ticketsRemaining = ticketsRemaining.add(1);
        validTicket[_tokenId] = false;
        
        removeTicketFromIndex(_owner, _tokenId);
        // reset approved address
        approvedAddress[_owner][_tokenId] = address(0);
        
        emit Transfer(_owner, address(0), _tokenId);        
        emit Approval(_owner, address(0), _tokenId);
        emit SupplyUpdate(1, false);
    }
    
    /** @dev Updates the status of the circuit breaker.
      * @param _status The new status of the circuit breaker.
      */ 
    function updateBreakerStatus(bool _status) onlyOwner external {
        stopExecution = _status;
    }
    
    /** @dev Updates the sale status of a ticket. False is notForSale.
      * @param _owner The owner of the ticket.
      * @param _tokenId the id of the ticket.
      * @param _forSale The sale status of the ticket
      */ 
    function ticketForSale(address _owner, uint256 _tokenId, bool _forSale) pending(_tokenId) external {
         if (msg.sender != _owner && approvedAddress[_owner][_tokenId] != msg.sender){
            require(approvedOperator[_owner][msg.sender] == true);
        }
        require(validTicket[_tokenId] == true);
        require(ticketOwners[_tokenId] == _owner);
        if (_forSale == false){
            tickets[_tokenId].status = Status.notForSale;
        }
        else if(_forSale == true) {
             tickets[_tokenId].status = Status.forSale;
        }
    }
    
    /** @dev Lookup owner ticket Id's by index
      * @param _owner The owner of the ticket.
      * @param _index The index of the ticket.
      */ 
    function ticketIndexLookup(address _owner, uint256 _index) public view returns (uint _tokenId){
        return ownerTickets[_owner][_index];
    }
    
    /** @dev Redeem a ticket for when entering event
      * @param _tokenId The id of the ticket to redeem 
      */ 
    function redeemTicket(uint256 _tokenId) pending(_tokenId) onlyOwner breakerInactive external{
        require(ticketOwners[_tokenId] != address(0));
        tickets[_tokenId].status = Status.redeemed;
    }
    
    /** @dev Returns the current price of tickets.
      * @return price The price of each ticket.
      */ 
    function ticketPrice() external view returns (uint256){
        return price;
    }

    /** @dev Returns the ticket name.
      * @return name The name of the ticket.
      */ 
    function ticketName() external view returns (string memory){
        return name;
    }

    /** @dev Returns the ticket code.
      * @return code The code for the ticket.
      */ 
    function ticketCode() external view returns (string memory){
        return code;
    }
    
    /** @dev Returns the number of remaining tickets.
      * @return ticketsRemaining The amount of tickets remaining. 
      */ 
    function remainingTickets() external view returns (uint256){
        return ticketsRemaining;
    }
    
     /** @dev Returns the status of the ticket.
      * @return status The status of the ticket. 
      */ 
    function ticketStatus(uint256 _tokenId) external view returns (Status status){
        require (ticketOwners[_tokenId] != address(0), "ticket invalid");
        status = tickets[_tokenId].status;
        return status;
    }
  
    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero
    function balanceOf(address _owner) external view returns (uint256){
        require(_owner != address(0));
        return ticketBalance[_owner];
    } 
    
    /** @dev Returns the owner of a specific ticket.
      * @param _tokenId the id of the ticket. 
      * @return ticketOwners[_tokenId] the address of the ticket owner. 
      */ 
    function ownerOf(uint256 _tokenId) external view returns (address){
        require (ticketOwners[_tokenId] != address(0));
        return ticketOwners[_tokenId];
    }
    
    
    /// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
    ///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
    ///  THEY MAY BE PERMANENTLY LOST
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    function transferFrom(address _from, address _to, uint256 _tokenId) breakerInactive external payable{
        // this is not payable and handles transferring of tickets without payment and doesn't increment tickets purchased
        
        // check valid request
         if (msg.sender != _from && approvedAddress[_from][_tokenId] != msg.sender){
            require(approvedOperator[_from][msg.sender] == true);
        }
        // prevent transfer to OxO address
        require(_to != address(0));
         // check for valid token_Id
        require(validTicket[_tokenId] == true);
        // check that from address holds the ticket
        require(ticketOwners[_tokenId] == _from);
        // update ticket holder
        ticketOwners[_tokenId] = _to;
        // update balances
        ticketBalance[_from] = ticketBalance[_from].sub(1);
        ticketBalance[_to] = ticketBalance[_to].add(1);
        
          //update ticket Status
        tickets[_tokenId].status = Status.notForSale;
       
        // add ticket index
        uint256 index = ticketsPurchased[_to];
        ownerTickets[_to][index] = _tokenId;
        removeTicketFromIndex(_from, _tokenId);
        
        // reset approved address
        approvedAddress[_from][_tokenId] = address(0);
        
        emit Transfer(_from, _to, _tokenId);
        emit Approval(_from, address(0), _tokenId);
    }
    /** @dev Purchase tickets from a specified address.
      * @param _owner The owner of the ticket.
      * @param _tokenId The id of the ticket.
      */ 
    function purchaseTicketsFrom(address payable _owner, uint256 _tokenId) breakerInactive  external payable{
        // this is payable and handles purchasing and transfering tickets from addresses with payment
        
        uint256 currentPrice = price;
        require(msg.value >= currentPrice);
        // can't buy ticket they own
        require(_owner != msg.sender);
        // check valid ticket
        require(validTicket[_tokenId] == true);
        //check buyer hasn't reached ticket purchase limit;
        require((ticketsPurchased[msg.sender] + 1) <= 20);
        // check owner owns ticket
        require(ticketOwners[_tokenId] == _owner);
        // ticket is forSale
        require(tickets[_tokenId].status == Status.forSale);
        // update owner
        ticketOwners[_tokenId] = msg.sender;
        // update purchase price
        tickets[_tokenId].purchasePrice = currentPrice;
        // update balances
        ticketBalance[_owner] = ticketBalance[_owner].sub(1);
        ticketBalance[msg.sender] = ticketBalance[msg.sender].add(1);
        //update ticket Status
        tickets[_tokenId].status = Status.notForSale;
        // transfer ether
        uint256 refundAmount = msg.value.sub(currentPrice);
        refundOverpay(refundAmount);
        _owner.transfer(currentPrice);
        assert((refundAmount + currentPrice) == msg.value);
       
        // add ticket index
        uint256 index = ticketsPurchased[msg.sender];
        ownerTickets[msg.sender][index] = _tokenId;
        // update tickets purchased
        ticketsPurchased[msg.sender] = ticketsPurchased[msg.sender].add(1);
        // remove ticket from owner index
        removeTicketFromIndex(_owner, _tokenId);
        // reset approved address
        approvedAddress[_owner][_tokenId] = address(0);

        emit Approval(_owner, address(0), _tokenId);
        emit TicketPurchased(_owner, msg.sender, _tokenId, tickets[_tokenId].purchasePrice);
    }
    
    /** @notice Tickets can only be refunded if the circuit breaker is active.
      * @dev Refund the owner of a ticket the amount the ticket
      *  was originally purchased for.  
      * @param _tokenId The id of the ticket.
      */ 
    function refundTicket (uint256 _tokenId) pending(_tokenId) breakerActive external {
        require(ticketOwners[_tokenId] == msg.sender);
        require(validTicket[_tokenId] == true);
        // refund amount
        uint256 amount = tickets[_tokenId].originalPrice;
        //reset original price to prevent re-entrancy attacks
        tickets[_tokenId].originalPrice = 0;
        // update variables
        ticketOwners[_tokenId] = address(0);
        validTicket[_tokenId] = false;
        ticketBalance[msg.sender] = ticketBalance[msg.sender].sub(1);
        removeTicketFromIndex(msg.sender, _tokenId);
        approvedAddress[msg.sender][_tokenId] = address(0);
        // transfer refund amount
        msg.sender.transfer(amount);
        
        emit Approval(msg.sender, address(0), _tokenId);
        emit Transfer(msg.sender, address(0), _tokenId);
    }
    
    /** @dev Removes a ticket from the owners tickets at its index.
      * @param _owner the address of the ticket owner.
      * @param _tokenId the id of the ticket.
      */ 
    function removeTicketFromIndex(address _owner, uint256 _tokenId) internal{
        uint256 p = ticketsPurchased[_owner];
        for (uint256 i = 0; i < p + 1; i++){
            if (ownerTickets[_owner][i] == _tokenId){
                delete ownerTickets[_owner][i];
            }
        }
    }
    
    /** @dev Gets the funds currently held at the contract address.
      * @return address(this).balance The balance of the contact.
      */ 
    function contractBalance() onlyOwner external view returns (uint256){
        return address(this).balance;
    }

    /** @dev withdraw funds from the contract and transfer it to the owner.
      */
    function withdrawBalance() onlyOwner external {
        msg.sender.transfer(address(this).balance);
    }
    
    /// @notice Set or reaffirm the approved address for an NFT
    /// @dev The zero address indicates there is no approved address.
    /// @dev Throws unless `msg.sender` is the current NFT owner, or an authorized
    ///  operator of the current owner.
    /// @param _approved The new approved NFT controller
    /// @param _tokenId The NFT to approve
    function approve(address _approved, uint256 _tokenId) pending(_tokenId) breakerInactive external payable{
        // set owner for getting authorized operator
        address owner = ticketOwners[_tokenId];
        if (msg.sender != ticketOwners[_tokenId]){
            require(approvedOperator[owner][msg.sender] == true);
        }
        // update approved address
        approvedAddress[msg.sender][_tokenId] = _approved;
        
        emit Approval(msg.sender, _approved, _tokenId);
    }
    /// @notice Enable or disable approval for a third party ("operator") to manage
    ///  all of `msg.sender`'s assets.
    /// @dev Emits the ApprovalForAll event. The contract MUST allow
    ///  multiple operators per owner.
    /// @param _operator Address to add to the set of authorized operators.
    /// @param _approved True if the operator is approved, false to revoke approval
    function setApprovalForAll(address _operator, bool _approved) breakerInactive external{
        // prevent approving oneself
        require(_operator != msg.sender);
        // prevent approving already approved
        require(approvedOperator[msg.sender][_operator] != _approved);
        // update approval status
        approvedOperator[msg.sender][_operator] = _approved;
        
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }
    /// @notice Get the approved address for a single NFT
    /// @dev Throws if `_tokenId` is not a valid NFT
    /// @param _tokenId The NFT to find the approved address for
    /// @return The approved address for this NFT, or the zero address if there is none
    function getApproved(uint256 _tokenId) external view returns (address){
        require(validTicket[_tokenId] == true);
        return approvedAddress[msg.sender][_tokenId];
    }

    /// @notice Query if an address is an authorized operator for another address
    /// @param _owner The address that owns the NFTs
    /// @param _operator The address that acts on behalf of the owner
    /// @return True if `_operator` is an approved operator for `_owner`, false otherwise
    function isApprovedForAll(address _owner, address _operator) external view returns (bool){
        return approvedOperator[_owner][_operator];
    }
}
