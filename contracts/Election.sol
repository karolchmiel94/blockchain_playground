// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10 <0.9.0;

// error AlreadyVoted(type name );

contract Election {
    address public organizer;
    string[] public candidateList;
    uint256 public votingStart;
    uint256 public votingEnd;
    string public winner;

    mapping(uint256 => uint256) private votesCount;
    mapping(address => bool) private voted;

    event Vote(uint256 index);
    event Winner(string winner, uint256 voteCount);

    modifier canVote() {
        require(!voted[msg.sender], "You can only vote once!");
        _;
    }

    modifier votingInProgress() {
        require(votingStart > block.timestamp, "Voting has not yet started");
        require(block.timestamp > votingEnd, "Voting has ended");
        _;
    }

    modifier organizerOnly() {
        require(msg.sender == organizer, "Permission denied");
        _;
    }

    constructor(
        string[] memory candidates_,
        uint256 votingStart_,
        uint256 votingEnd_
    ) {
        organizer = msg.sender;
        candidateList = candidates_;
        votingStart = votingStart_;
        votingEnd = votingEnd_;
    }

    function placeVote(uint256 candidate) public canVote votingInProgress {
        require(candidateList.length > candidate, "Invalid candidate");
        voted[msg.sender] = true;
        votesCount[candidate]++;
    }

    function closeVoting() public organizerOnly {
        require(msg.sender == organizer, "Operation not allowed");
        string memory _winner;
        uint256 _winnerVotes = 0;
        for (uint256 i = 0; i < candidateList.length; i++) {
            if (votesCount[i] > _winnerVotes) {
                _winner = candidateList[i];
                _winnerVotes = votesCount[i];
            }
        }
        winner = _winner;
        emit Winner(winner, _winnerVotes);
    }
}
