const OsirisNFT = artifacts.require("OsirisNFT");
const OsirisToken = artifacts.require("OsirisToken");

// ============ Main Migration ============

const migration = async (deployer, network, accounts) => {
  await Promise.all([deployToken(deployer, network, accounts)])
}

module.exports = migration

// ============ Deploy Functions ============

async function deployToken(deployer, network, accounts) {
  if (['dev'].includes(network)) {
    console.log('Deploying NFTToken on Dev network.');
    deployer.deploy(OsirisNFT, 'OsirisNFT', 'OSRNFT', accounts[0], accounts[1]);
    console.log('Deploying OsirisToken on Dev network.');
    deployer.deploy(OsirisToken, 'OsirisToken', 'OSR', accounts[0], accounts[1], accounts[2]);

  }else{
    console.log('Deploying NFTToken on Ropsten network.');
    deployer.deploy(OsirisNFT, 'OsirisNFT', 'OSRNFT', '0x7C00DEA96b882558ae721a6410136D37555Ee698','100000000000000000');
    console.log('Deploying OsirisToken on Ropsten network.');
    deployer.deploy(OsirisToken, 'Osiris', 'OSR', '0x7C00DEA96b882558ae721a6410136D37555Ee698', '0x7C00DEA96b882558ae721a6410136D37555Ee698', '0x7C00DEA96b882558ae721a6410136D37555Ee698');
  }
}

