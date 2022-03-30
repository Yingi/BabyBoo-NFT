# NFT Project

This is an ERC1155 NFT Project

The nft was deployed on the polygon chain

It also contains a visualiser written in react

First:

> npm install

After this, 

> cd SiteFrontend


You have to now install the packages that was used in the frontend

> npm install

Now that you have installed all dependencies, you can begin deploying your own custom nfts

You can deploy your nft smart contract by adding your own jpg files and then configure your metamask by adding the polygon network rpc. You can deploy with testnet also

Add a .env files at the root directory of your project

Get your polygon testnet or mainnet rpc and your Matic account private key. NOTE: YOUR PRIVATE KEY SHOULD BE SECURED AT ALL TIMES.

Your .env file should look like this:

POLYGON_MAINNET_URL=https://polygon-rpc.com/
PRIVATE_KEY=XXXXX-YOUR_PRIVATE_KEY-XXXXXXXXX

POLYGON_TESTNET=https://matic-mumbai.chainstacklabs.com
PRIVATE_KEY_TESTNET=XXXXX-YOUR_PRIVATE_KEY-XXXXXXXXX



After configuring your accounts, you can now deploy your nft smart contract to polygon.
