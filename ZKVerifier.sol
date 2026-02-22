// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title ZKVerifier
 * @dev Verifies membership in a private set using Merkle Proofs.
 */
contract ZKVerifier is Ownable {
    bytes32 public merkleRoot;

    event Verified(address indexed account);

    constructor(bytes32 _merkleRoot) Ownable(msg.sender) {
        merkleRoot = _merkleRoot;
    }

    /**
     * @dev Updates the Merkle Root for new batches of members.
     */
    function updateRoot(bytes32 _newRoot) external onlyOwner {
        merkleRoot = _newRoot;
    }

    /**
     * @dev Checks if the caller is part of the private Merkle Tree.
     * @param proof The sibling hashes required to reconstruct the root.
     */
    function checkMembership(bytes32[] calldata proof) external {
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        
        require(
            MerkleProof.verify(proof, merkleRoot, leaf),
            "ZKVerifier: Invalid proof or not a member"
        );

        emit Verified(msg.sender);
    }
}
