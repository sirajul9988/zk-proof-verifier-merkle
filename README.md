# ZK-Proof Verifier (Merkle Membership)

This repository implements a professional Zero-Knowledge inspired membership verification system. It uses Merkle Trees to allow users to verify their inclusion in a set (like a whitelist or an authorized group) while maintaining privacy and gas efficiency.

### Technical Architecture
* **Privacy-Centric:** Users provide a "Merkle Proof" rather than their address to check permissions.
* **Gas Optimized:** Storing a single 32-byte `root` hash on-chain instead of thousands of individual addresses.
* **Solidity ^0.8.20:** Uses the latest OpenZeppelin MerkleProof library for battle-tested security.
* **Flat Structure:** All logic and deployment helpers are located in the root for easy access.

### How it Works
1. **Off-Chain:** Generate a Merkle Tree from a list of addresses and compute the `root`.
2. **On-Chain:** Deploy the contract with the `root`.
3. **Verification:** A user submits a proof (list of sibling hashes) to the contract. The contract hashes the caller's address with the proof to see if it matches the stored `root`.



### Implementation Guide
1. Run `node generate-root.js` to get your Merkle Root.
2. Deploy `ZKVerifier.sol` with that root.
3. Use the proof output to call `verify()`.
