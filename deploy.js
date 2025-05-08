// scripts/deploy.js
const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);
  console.log("Account balance:", (await ethers.provider.getBalance(deployer.address)).toString());

  // Get the ContractFactory for your VotingSystem contract
  const VotingSystem = await ethers.getContractFactory("votingSystem");

  // Deploy the contract
  const votingSystem = await VotingSystem.deploy();

  await votingSystem.waitForDeployment();

  console.log("VotingSystem deployed to:", await votingSystem.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });