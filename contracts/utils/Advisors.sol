// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.12;

import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/math/SafeMath.sol';


// 10% 6 months after TGE and 5% quartely

contract Advisors is Ownable {  
  using SafeMath for uint256;

  uint private constant max = 28e5 * 1e18;

  uint private constant amountFirstRelease = max*10/100;
  uint private constant amountEachRelease = max*5/100;
  
  uint private released = 0;  
  
  uint private periodReleased = 180 days;
  uint private lastReleased = block.timestamp + periodReleased;

  function getReleased() public view returns(uint) {
    return released;
  }
  
  function release() public onlyOwner returns(uint){
    uint amount = 0;

    require(block.timestamp - lastReleased >= periodReleased, 'Please wait to next checkpoint');

    if(periodReleased == 180 days){
      require(released.add(amountFirstRelease) <= max, 'Max advisors allocation released');

      amount = amountFirstRelease;

      released = released.add(amount);

      periodReleased = 90 days;
    }      
    else{
      require(released.add(amountEachRelease) <= max, 'Max advisors allocation released');

      amount = amountEachRelease;
      
      released = released.add(amount);
    }      
    
    lastReleased = lastReleased + periodReleased;

    return amount;
  }  
}
