// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.12;

import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/math/SafeMath.sol';

// 20% on TGE, 10% monthly
contract PrivateRound is Ownable{  
  using SafeMath for uint256;

  uint private constant max = 28e6 * 1e18;
  uint private constant amountEachRelease = max*10/100;

  uint private released = max*20/100;
  uint private lastReleased = block.timestamp + 30 days;

  function getReleased() public view returns(uint) {
    return released;
  }
  
  function release() public onlyOwner returns(uint) {       
    require(released.add(amountEachRelease) <= max, 'Max private round allocation released');
    require(block.timestamp - lastReleased >= 30 days, 'Please wait to next checkpoint');

    uint amount = amountEachRelease;

    released = released.add(amount);
    lastReleased = lastReleased + 30 days;
  
    return amount;
  }
}
