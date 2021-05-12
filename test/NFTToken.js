const NFTToken = artifacts.require("NFTToken");

contract("NFTToken", accounts => {
    it("Check contract name", () => {
        return NFTToken.deployed()
            .then(instance => {
                return instance.name.call()                
            })
            .then(name => {
                assert.equal(name, 'Osiris', 'Contract name\'s Osiris');
            })
    });

    it("mint NFT tokenId 1 to account[0]", function() {
        return NFTToken.deployed().then(function(instance) {
          NFTInstance = instance;
    
          return NFTInstance.mint(accounts[0], 1, 'metadata', {from: accounts[0]});
        })
    });
});