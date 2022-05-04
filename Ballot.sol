pragma solidity ^0.5.0;

contract Ballot{
    int public proposalCount = 0;
    struct Voter {
        address x;
    }
    struct Proposal{
        int proposalID; 
        int numPos;
        int numNeg;
        string title;
        string content;
    }
    mapping(int => Proposal) public proposals;
    mapping(address => bool) public voterAdded;
    mapping(address => mapping(int => int)) public voters; //address to voter

    event ProposalCreated(
        int proposalID,
        int numPos,
        int numNeg,
        string title,
        string content
    );

    event VoterAdded(
        address x
    );

    event change(
        int numPos,
        int numNeg
    );
/*
    event ItemUpvoted(	
        int proposalID,	
        int currentVote
    );

    event ItemDownvoted(	
        int proposalID,	
        int currentVote
    );
*/

    constructor() public{
        createProposal("Should SAS renovate their library?", "Here is a reason for this proposal.Here is a reason for this proposal.Here is a reason for this proposal.Here is a reason for this proposal.Here is a reason for this proposal.");
        createProposal("Should athletics be de-emphasised?", "At our school, we are constantly told about the accomplishments of IASAS athletes. We have pep rallies, and IASAS athletes are given red bags. In one of the house assemblies, all athletes were asked to stand up, for their different sports. Imagine what if felt like for those who didn’t take part in athletics, when they were the only people standing up. This would be fine if they were recognized, but quite frankly, they aren’t. We are constantly asked to “Support our Eagles” at athletic events, but for CulCon, nobody really cares. This issue is further worsened with the Scholars Luncheon. The GPA requirement is 3.7, which is low enough for a great number of people to qualify for it. But for those who aren’t as good academically, they would feel extremely bad when half the school goes to the gym one lunch. Furthermore, those who have very good GPAs, like having above a 4.1, can’t feel recognized because they are being recognized with half the school, “diluting” their recognition.");
        addVoter(0x0D3FE60dDDcaD85B534EA8b291cd7bc04bc5f3ef);
    }

    function addVoter(address add) public{
        voterAdded[add] = true;
        emit VoterAdded(add);
        for(int i = 0; i < proposalCount; i++){
            voters[add][i] = 0;
        }
    }

    function createProposal(string memory _title, string memory _content) public{
        proposalCount++;
        proposals[proposalCount] = Proposal(proposalCount, 0,0,_title, _content);
        emit ProposalCreated(proposalCount,0,0,_title,_content);
    }

    function proposalUpvoted(int proposalID, address voterAddress) public{
        int currentVote = voters[voterAddress][proposalID];
      /*  if(currentVote == 1){
            voters[voterAddress][proposalID] = 0;
            proposals[proposalID].numPos -= 1;
        }
        else if(currentVote == 0){
            voters[voterAddress][proposalID] = 1;
            proposals[proposalID].numPos += 1;
        }else if(currentVote == -1){
            voters[voterAddress][proposalID] = 1;
            proposals[proposalID].numPos++;
            proposals[proposalID].numNeg--;
        }*/
        emit change(proposals[proposalID].numPos,proposals[proposalID].numNeg);
    }

    function proposalDownvoted(int proposalID, address voterAddress) public{
        int currentVote = voters[voterAddress][proposalID];
        if(currentVote == 1){
            voters[voterAddress][proposalID] = -1;
            proposals[proposalID].numPos--;
            proposals[proposalID].numNeg++;
        }
        else if(currentVote == 0){
            //voters[voterAddress][proposalID] = -1;
            proposals[proposalID].numNeg++;
        }else if(currentVote == -1){
            voters[voterAddress][proposalID] = 0;
            proposals[proposalID].numNeg--;
        }
        emit change(proposals[proposalID].numPos,proposals[proposalID].numNeg);
    }

}