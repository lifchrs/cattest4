pragma solidity ^0.5.0;

contract TodoList{
    int public itemCount = 0;

    struct Item{
        int id; 
        int numPos;
        int numNeg;
        string title;
        string content;
        int currentVote; //0 means not voted, -1 means downvote, 1 means upvote  
    }
    mapping(int => Item) public items;

    event ItemCreated(
        int id,
        int numPos,
        int numNeg,
        string title,
        string content,
        int currentVote
    );

    event change(
        int numPos,
        int numNeg
    );
/*
    event ItemUpvoted(	
        int id,	
        int currentVote
    );

    event ItemDownvoted(	
        int id,	
        int currentVote
    );
*/

    constructor() public{
        createItem("Should SAS renovate their library?", "Here is a reason for this item.Here is a reason for this item.Here is a reason for this item.Here is a reason for this item.Here is a reason for this item.");
        createItem("Should athletics be de-emphasised?", "At our school, we are constantly told about the accomplishments of IASAS athletes. We have pep rallies, and IASAS athletes are given red bags. In one of the house assemblies, all athletes were asked to stand up, for their different sports. Imagine what if felt like for those who didn’t take part in athletics, when they were the only people standing up. This would be fine if they were recognized, but quite frankly, they aren’t. We are constantly asked to “Support our Eagles” at athletic events, but for CulCon, nobody really cares. This issue is further worsened with the Scholars Luncheon. The GPA requirement is 3.7, which is low enough for a great number of people to qualify for it. But for those who aren’t as good academically, they would feel extremely bad when half the school goes to the gym one lunch. Furthermore, those who have very good GPAs, like having above a 4.1, can’t feel recognized because they are being recognized with half the school, “diluting” their recognition.");
    }

    function createItem(string memory _title, string memory _content) public{
        itemCount++;
        items[itemCount] = Item(itemCount, 0,0,_title, _content, 0);
        emit ItemCreated(itemCount,0,0,_title,_content,0);
    }

    function itemUpvoted(int id) public{
        int currentVote = items[id].currentVote;
        if(currentVote == 1){
            items[id].currentVote == 0;
            items[id].numPos -= 1;
        }
        else if(currentVote == 0){
            items[id].currentVote = 1;
            items[id].numPos += 1;
        }else if(currentVote == -1){
            items[id].currentVote = 1;
            items[id].numPos++;
            items[id].numNeg--;
        }
        emit change(items[id].numPos,items[id].numNeg);
    }

    function itemDownvoted(int id) public{
        if(items[id].currentVote == 1){
            items[id].currentVote == -1;
            items[id].numPos--;
            items[id].numNeg++;
        }
        else if(items[id].currentVote == 0){
            items[id].currentVote = -1;
            items[id].numNeg++;
        }else if(items[id].currentVote == -1){
            items[id].currentVote = 0;
            items[id].numNeg--;
        }
        emit change(items[id].numPos,items[id].numNeg);
    }

}