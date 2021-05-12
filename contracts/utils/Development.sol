// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.12;

import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/math/SafeMath.sol';

contract Development is Ownable {  
  using SafeMath for uint256;

  uint private constant max = 84e5 * 1e18;
  uint private constant amountFirstMonthRelease = max*5/100;
  uint private constant amountEachRelease = max*2/100;

  // 12 months lock, 5% for 1st Month and 2% monthly
  uint private released = 0;
  int private twelveMonthsLock = 12;
  uint private lastReleased = block.timestamp + 30 days;  

  function getReleased() public view returns(uint) {
    return released;
  }
  
  function release() public onlyOwner returns(uint){
    uint amount = 0;

    require(block.timestamp - lastReleased >= 30 days, 'Please wait to next checkpoint');

    // First month after lock
    if(twelveMonthsLock == 0){
      require(released.add(amountFirstMonthRelease) <= max, 'Max development allocation released');

      amount = amountFirstMonthRelease;

      released = released.add(amount);
      twelveMonthsLock--;
    }
    else if(twelveMonthsLock < 0){
      require(released.add(amountEachRelease) <= max, 'Max development allocation released');

      amount = amountEachRelease;

      released = released.add(amount);
    }
    else{
      twelveMonthsLock--;
    }      

    lastReleased = lastReleased + 30 days;

    return amount;
  }  
}
