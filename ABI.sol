// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract EncodeDecode {

// Encode each of  the arguments into bytes
    function encode(
        uint x,
        address addr,
        uint[] calldata arr
    ) external pure returns (bytes memory) {
        return abi.encode(x, addr, arr);
    }

    function decode(bytes calldata bytesData)
        external
        pure
        returns (
            uint x,
            address addr,
            uint[] memory arr
        )
    {
        (x, addr, arr) = abi.decode(bytesData, (uint, address, uint[]));
    }


    function compareStrings(string memory str1, string memory str2)
            public
            pure
            returns (bool)
        {
            return (keccak256(abi.encodePacked((str1))) ==
                keccak256(abi.encodePacked((str2))));
        }
}
