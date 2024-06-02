// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


// The contract does the following things:
// 1. Makes the deployer of the contract the owner.
// 2. Has fund() function to receive Ether from other accounts.
// 3. Has withdraw() function only accessible to the owner. This function sends all Ether present in the contract to the owner's account.





error NotOwner();

contract FundContract {

    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;

 
    address public immutable owner;
    uint256 public constant MINIMUM_USD = 5 * 10 ** 18;

    constructor() {
        owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value >= 1e18, "You need to send more ETH!");
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    modifier onlyOwner() {
        // require(msg.sender == owner);
        if (msg.sender != owner) revert NotOwner();
        _;
    }

    function withdraw() public onlyOwner {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        //transfer
        //payable(msg.sender).transfer(address(this).balance);

        // // send
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "Send failed");

        // call
        // (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        // require(callSuccess, "Call failed");
    }



    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }
}
