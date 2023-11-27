const { assert } = require("chai");

describe("myERC20Token", function () {
  it("Deployment should assign the total supply of tokens to the owner", async function () {
    const [owner] = await ethers.getSigners();

    const myERC20Token = await ethers.deployContract("myERC20Token");

    const ownerBalance = await myERC20Token.balanceOf(owner.address);
    assert.equal(await myERC20Token.totalSupply(), ownerBalance);
  });
});