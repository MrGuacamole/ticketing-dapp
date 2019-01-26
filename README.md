# Decentralized Ticketing Application
This is a decentralized ticketing application built using truffle for Ethereum. Users can purchase tickets, manage them and transfer them between accounts. Tickets can be purchased from the vendor or from other users. The owner also has specific administrative abilities.

The purpose of the application is to utilize blockchain technology to provide a safe and secure outlet for purchasing tickets for any event type, benefiting ticket vendors and customers alike. It limits the impact of ticket touts by ensuring that tickets are paid at the vendors price. It also eliminates scammers by providing customers with the ability to lookup ticket information and ensure the transfer is done within a single transaction.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Prerequisites

#### Node.js and npm - Linux (Ubuntu)

Update packages list
```
sudo apt update
```
Install node.js via apt package manager
```
sudo apt install nodejs
```
Verify installation
```
node -v
```
Install npm
```
sudo apt install npm
```
Verify installation
```
npm -v
```
#### Node.js and npm - Windows
Download the Windows installer from [here](https://nodejs.org/en/download/) and follow the instructions.

In the windows terminal verify node
```
node -v
```
Then verify npm
```
npm -v
```
### Installing
#### Note: Linux installation may need to be prefixed with 'sudo'

1. Install truffle globally
```
npm install -g truffle
```
2. Install ganache globally
```
npm install -g ganache-cli
```
3. Clone repository
```
git clone https://github.com/MrGuacamole/ticketing-dapp.git
```
4. Navigate to root project folder and install node modules
```
npm install
```

## Deployment
#### Note: compiling and migrating contracts on Linux may need to be prefixed with 'sudo' 

1. Start ganache by entering the following 
```
ganache-cli
```
2. Compile the contracts in a new terminal
```
truffle compile
```
3. Migrate the contracts onto ganache
```
truffle migrate
```
4. Launch the development server
```
npm run dev
```
Now the application is ready to interact with.

## Running the tests

To run the pre-written tests run the following command while in the root project folder
```
truffle test
```
## User Stories
As a customer I want to lookup a ticket so I can see if it's valid, who owns it and if it's for sale.

As a customer I want to purchase a ticket so I can go to the concert.

As a customer I want a list of my tickets so I can manage them and see which ones I own.

As a customer I want to refund my ticket so I can keep my funds if the concert is cancelled.

As a customer I want to approve an operator so they can manage my tickets on my behalf.

As a customer I want to transfer tickets so I can give them to my friend without them needing to pay.

As the owner I want to update the ticket price so that it is accurate.

As the owner I want to add tickets so there are more for customers to purchase.

As the owner I want to burn tickets so there isn't a large number unsold.

As the owner I want to withdraw the balance so I can receive the funds from ticket sales.

As the owner I want to redeem a ticket so I can let customers into the concert.
