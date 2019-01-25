# Decentralized Ticketing Application
This is a decentralized ticketing application built using truffle on Ethereum.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

#### Node.js and npm - Linux (Ubuntu)

Update packages list
```
sudo apt update
```

Install node.js via apt package manager
```
sudo apt install nodejs npm
```
Verify installation
```
nodejs --version
```
Install npm
```
sudo apt install npm
```
Verify installation
```
npm --version
```
#### Node.js and npm - Windows
Download the Windows installer from [here](https://nodejs.org/en/download/) and follow the instructions.

Verify node
```
node -v
```
Verify npm
```
npm -v
```
### Installing

1. Install truffle globally
```
npm install -g truffle
```
2. Install ganache globally
```
npm install -g ganche-cli
```
3. Install lite-server (global install optional)
```
npm install -g lite-server
```
## Deployment

1. Clone the repository and navigate to the root project folder
2. Start ganache by entering the following 
```
ganache-cli
```
3. Compile the contracts
```
truffle compile
```
4. Migrate the contracts onto ganache
```
truffle migrate
```
5. Launch the development server
```
npm run dev
```
Now the application is ready to interact with.

## Running the tests

To run the pre-written tests run the following command while in the root project folder
```
truffle test
```
