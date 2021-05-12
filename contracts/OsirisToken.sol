// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.12;

//import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '@openzeppelin/contracts/token/ERC20/ERC20Capped.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

import './utils/PrivateRound.sol';
import './utils/Marketing.sol';
import './utils/Liquidity.sol';
import './utils/Team.sol';
import './utils/Development.sol';
import './utils/Advisors.sol';

contract OsirisToken is ERC20Capped, Ownable {
  PrivateRound private privateRound;
  Marketing private marketing;
  Liquidity private liquidity;
  Team private team;
  Advisors private advisors;
  Development private development;

  uint private constant publicSaleMax = 14e5 * 1e18;
  uint private publicSaleReleased = publicSaleMax; // 100% TGE  

  constructor(
    string memory _name, string memory _symbol,
    address _privateRoundTGEAddress,
    address _publicSaleTGEAddress,
    address _liquidityTGEAddress
  ) public ERC20(_name, _symbol) ERC20Capped(7e7*1e18) {    
    privateRound = new PrivateRound();
    marketing = new Marketing();
    liquidity = new Liquidity();
    team = new Team();
    advisors = new Advisors();
    development = new Development();
   
    _mint(address(this), 7e7 * 1e18);
    //_mint(msg.sender, 7e7 * 1e18);

    _transfer(address(this), _privateRoundTGEAddress, privateRound.getReleased());
    _transfer(address(this), _publicSaleTGEAddress, publicSaleReleased);
    _transfer(address(this), _liquidityTGEAddress, liquidity.getReleased());
  }  

  function getReleasedOfPrivateRound() public view returns(uint){
    return privateRound.getReleased();
  }

  function releasePrivateRound(address _receiver) public onlyOwner {
    uint release = privateRound.release();
    if(release > 0)
      _transfer(address(this), _receiver, release);      
  }

  function getReleasedOfPublicSale() public view returns(uint){
    return publicSaleReleased;
  }

  function getReleasedOfMarketing() public view returns(uint){
    return marketing.getReleased();
  }

  function releaseMarketing(address _receiver) public onlyOwner {    
    uint release = marketing.release();
    if(release > 0)
      _transfer(address(this), _receiver, release);      
  }

  function getReleasedOfLiquidity() public view returns(uint){
    return liquidity.getReleased();
  }

  function releaseLiquidity(address _receiver) public onlyOwner {    
    uint release = liquidity.release();
    if(release > 0)
      _transfer(address(this), _receiver, release);
  }

  function getReleasedOfTeam() public view returns(uint){
    return team.getReleased();
  }

  function releaseTeam(address _receiver) public onlyOwner {
    uint release = team.release();
    if(release > 0)
      _transfer(address(this), _receiver, release);
  }

  function getReleasedOfAdvisors() public view returns(uint){
    return advisors.getReleased();
  }

  function releaseAdvisors(address _receiver) public onlyOwner {    
    uint release = advisors.release();
    if(release > 0)
      _transfer(address(this), _receiver, release);
  }

  function getReleasedOfDevelopment() public view returns(uint){
    return development.getReleased();
  }

  function releaseDevelopment(address _receiver) public onlyOwner {
    uint release = development.release();
    if(release > 0)
      _transfer(address(this), _receiver, release);      
  }
}
