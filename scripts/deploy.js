const { ethers } = require("hardhat")

const main = async () => {
  const myerc = await ethers.deployContract("myERC20Token")
  await myerc.waitForDeployment();
  console.log(myerc.target);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
