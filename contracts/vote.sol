// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import { FHE, euint32, externalEuint32 } from "@fhevm/solidity/lib/FHE.sol";
import { SepoliaConfig } from "@fhevm/solidity/config/ZamaConfig.sol";

contract AnonymousVoting is SepoliaConfig {
    struct Candidate {
        string name;
        euint32 voteCount;
    }

    mapping(uint256 => Candidate) public candidates;
    mapping(address => bool) public hasVoted;
    uint256 public candidatesCount;

    constructor() {}

    function addCandidate(string memory _name) public {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(_name, FHE.asEuint32(0));
    }

    function vote(uint256 _candidateId) public {
        require(!hasVoted[msg.sender], "You have already voted.");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID.");

        hasVoted[msg.sender] = true;
        euint32 currentVotes = candidates[_candidateId].voteCount;
        candidates[_candidateId].voteCount = currentVotes + FHE.asEuint32(1);
    }

    /// @notice Returns encrypted vote count (for frontend decryption)
    function getEncryptedVoteCount(uint256 _candidateId) public view returns (externalEuint32) {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID.");
        return FHE.asExternal(candidates[_candidateId].voteCount);
    }

    /// @notice Only for debug or internal use. Decrypt on-chain (owner access recommended)
    function getDecryptedVoteCount(uint256 _candidateId) public view returns (uint32) {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID.");
        return FHE.decrypt(candidates[_candidateId].voteCount);
    }
}
