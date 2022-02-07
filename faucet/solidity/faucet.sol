/**
 * @file faucet.sol
 */

pragma solidity ^0.8.0;

contract faucet {
  address public me;

  struct requester {
    address requesteraddress;
    uint256 amount;
  }

  requester[] public requesters;

  constructor() public payable {
    me = msg.sender;
  }

  event sent(uint256 _amountsent);
  event received();

  function receive() public payable {
    emit received();
  }

  function send(address payable _requester, uint256 _request) public payable {
    uint256 amountsent = 0;
    _request = _request * 1e18;

    if (address(this).balance > _request) {
      amountsent = _request / 1e18;
      _requester.transfer(_request);
    } else {
      amountsent = (address(this).balance) / 1e18;
      _requester.transfer(address(this).balance);
    }

    requester memory r;
    r.requesteraddress = _requester;
    r.amount = amountsent;
    requesters.push(r);
    emit sent(amountsent);
  }
}
