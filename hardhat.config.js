require("dotenv").config();
require("@nomicfoundation/hardhat-toolbox");



/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",
  networks: {
    sepolia: {
      url: "https://rpc2.sepolia.org",
      accounts: [process.env.WALLET_KEY],
    }
  },
  etherscan:{
    apiKey:"EK4UAXPPGPSE2FVYUIYQT3IYCWX1K1DESE"
  }
};
