const { assert } = require("chai");

describe("myERC20Token", function () {
  let myERC20Token;
  beforeEach(async () => {
    myERC20Token = await ethers.deployContract("myERC20Token")
  })

  it("Deployment should assign the total supply of tokens to the owner", async function () {
    const [owner] = await ethers.getSigners();

    const ownerBalance = await myERC20Token.balanceOf(owner.address);
    assert.equal(await myERC20Token.totalSupply(), ownerBalance);
  });

  it("Should transfer tokens between accounts", async function () {
    const [owner, addr1, addr2] = await ethers.getSigners();

    // Transfer 50 tokens from owner to addr1
    await myERC20Token.transfer(addr1.address, 50);
    assert.equal(await myERC20Token.balanceOf(addr1.address), 50);

    // Transfer 50 tokens from addr1 to addr2
    await myERC20Token.connect(addr1).transfer(addr2.address, 40);
    assert.equal(await myERC20Token.balanceOf(addr2.address), 40);
  });
});