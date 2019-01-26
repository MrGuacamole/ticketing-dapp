# Decentralized Ticketing Application
This is a decentralized ticketing application built using truffle for Ethereum. Users can purchase tickets, manage them and transfer them between accounts. Tickets can be purchased from the vendor or from other users. The owner also has specific administrative abilities.

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
#### Note Linux installation may need to be prefixed with 'sudo'

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
#### Note: compiling and migrating on Linux may need to be prefixed with 'sudo' 

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
