// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.9;

contract Election{

    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Read/write Candidates
    mapping(uint => Candidate) public candidates;

    // Store accounts that have voted
    mapping(address => bool) public voters;

    // event to trigger the update on front end
    event votedEvent(uint indexed_candidateId);

    uint public candidateCount=0;

    constructor() public{
         addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate(string memory _name) private{
        candidateCount ++;
        candidates[candidateCount]=Candidate(candidateCount,_name,0);
    }

    function vote (uint256 _candidateId) public{

        // require candidate hasn't voted before
        require(!voters[msg.sender]);

        // require valid candidate
        require(_candidateId>0 && _candidateId<=candidateCount);

        // record the vote count
        voters[msg.sender]=true;
        
        // update candidate vote count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }

}
