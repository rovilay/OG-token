// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const OGERC20 = await hre.ethers.getContractFactory("OGERC20");
  const ogToken = await OGERC20.deploy(100000, "OGToken", "OG");

  await ogToken.deployed();

  console.log("OGERC20 with 1000000 token balance deployed to:", ogToken.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
