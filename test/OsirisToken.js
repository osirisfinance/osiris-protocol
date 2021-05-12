const OsirisToken = artifacts.require("OsirisToken");
const fromWei = web3.utils.fromWei;

const totalSupply = 70000000
const maxPrivateRound = totalSupply*40/100
const releasedPrivateRoundOnTGE = maxPrivateRound*20/100
const releasedPrivateRoundOnFirstMonth = releasedPrivateRoundOnTGE + maxPrivateRound*10/100

const maxPublicSale = totalSupply*2/100
const releasedPublicSaleOnTGE = maxPublicSale

const maxLiquidity = totalSupply*20/100
const releasedLiquidityOnTGE = maxLiquidity*5/1000

contract("OsirisToken", accounts => {
    let osirisToken;

    OsirisToken.deployed()
        .then(instance => {
            osirisToken = instance
        })

    
    it("Check contract constructor", () => {
        return osirisToken.name.call()
            .then(name => {
                assert.equal(name, 'Osiris');
            })
    });

    it("Checking PrivateRound on TGE", () => {
        return osirisToken.getReleasedOfPrivateRound.call()
            .then(released => {
                assert.equal(fromWei(released, 'ether'), releasedPrivateRoundOnTGE);
            })
    });

    it("Checking PrivateRound on First Month", () => {
        return osirisToken.releasePrivateRound.call('0x2136Ead37C02010a1667D9Aa63D464036698d4D2')
            .then(() => {
                return osirisToken.getReleasedOfPrivateRound.call()
            })
            .then(released => {
                assert.equal(fromWei(released, 'ether'), releasedPrivateRoundOnFirstMonth);
            })
    });

    it("Checking Private Round on TGE", () => {
        return osirisToken.getReleasedOfPrivateRound.call()
            .then(released => {
                assert.equal(fromWei(released, 'ether'), releasedPrivateRoundOnTGE);
            })
    });

    it("Checking Public Sale on TGE", () => {
        return osirisToken.getReleasedOfPublicSale.call()
            .then(released => {
                assert.equal(fromWei(released, 'ether'), releasedPublicSaleOnTGE);
            })
    });

    it("Checking Liquidity on TGE", () => {
        return osirisToken.getReleasedOfLiquidity.call()
            .then(released => {
                assert.equal(fromWei(released, 'ether'), releasedLiquidityOnTGE);
            })
    });
});