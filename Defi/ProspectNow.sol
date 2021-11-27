// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

/*
    Get real estate price when user input zip state using ProspectNow
 */
contract ProspectNow is ChainlinkClient {
    using Chainlink for Chainlink.Request;

    /**
     * Network: Kovan - https://market.link/data-providers/c8fc4b66-66a5-4e24-8d11-85d19553c03c/integrations
     * Chainlink oracle - 0xfF07C97631Ff3bAb5e5e5660Cdf47AdEd8D4d4Fd
     * Chainlink jobId - c9df8b4e40a44927aa6e839a3af82ce9
     * Fee: 0.1 LINK
     */
    constructor() public {
        setPublicChainlinkToken();
        oracle = 0xfF07C97631Ff3bAb5e5e5660Cdf47AdEd8D4d4Fd;
        jobId = "c9df8b4e40a44927aa6e839a3af82ce9";
        fee = 0.1 * 10 ** 18; // 0.1 LINK
    }

    address private oracle;
    bytes32 private jobId;
    uint256 private fee;   

    // Mapping from address to uint
    mapping(address => string) public myMap;

    // Get the price when input state
    function setZipState(string memory _propertyZip) public returns (bytes32 requestId) {
        Chainlink.Request memory req = buildChainlinkRequest(jobId, address(this), this.fulfillProspectNow.selector);
        req.add("propertyZip", _propertyZip);
        // Update the value at this address
        address _addr = msg.sender;
        myMap[_addr] = _propertyZip;
        return sendChainlinkRequestTo(oracle, req, fee);
    }

    function remove(address _addr) public {
        // Reset the value to the default value.
        delete myMap[_addr];
    }

    uint256 public prospectNowData;

    function fulfillProspectNow(bytes32 _requestId, uint256 _data) public recordChainlinkFulfillment(_requestId) {
        prospectNowData = _data;
    }
}