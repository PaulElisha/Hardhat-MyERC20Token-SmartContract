require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config()
/** @type import('hardhat/config').HardhatUserConfig */

const SEPOLIA_RPC_URL = process.env;
const PRIVATE_KEY = process.env;
const ETHERSCAN_API = process.env

module.exports = {
  solidity: "0.8.19",
  defaultNetwork: "hardhat",
};
