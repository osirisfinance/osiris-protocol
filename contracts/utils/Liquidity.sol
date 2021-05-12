// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.12;

import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/math/SafeMath.sol';

// 0.5% TGE, reward
contract Liquidity is Ownable{  
  using SafeMath for uint256;

  uint private constant max = 14e6 * 1e18;
  uint private constant amountEachRelease = 6500;

  uint private released = max*5/1000;
  uint private lastReleased = block.timestamp + 1 days;

  function getReleased() public view returns(uint) {
    return released;
  }
  
  function release() public onlyOwner returns(uint) {       
    require(released.add(amountEachRelease) <= max, 'Max liquidity allocation released');
    require(now - lastReleased >= 1 days, 'Please wait to next checkpoint');

    uint amount = amountEachRelease;

    released = released.add(amount);
    lastReleased = lastReleased + 1 days;
  
    return amount;
  }
}
