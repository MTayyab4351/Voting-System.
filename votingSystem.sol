// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.22 <0.9.0;

contract votingSystem{

    address owner;
    constructor(){
        owner=msg.sender;
    }


//Store candidate details
    struct candidate{
        string name;
        string description;
        uint age;
        bool approved;
        uint votes;
        
    }
    mapping(address=>candidate) public candidates;

//Store voter details

    struct voter{
        string name;
        uint age;
        uint  votedCandidateId;
        bool hasVoted;
        
    }

    mapping (address=>voter) public voters;

//To restrict function    
    modifier onlyOwner(){
       require(owner==msg.sender,"only owner can call this function");
       _;
    }



 //Events emit when candidate is registered
    event candidateRegister(string name,uint age,string description,address candidate);

   

//Event emit when voter is registered   
      event VoterRegister(string name,uint age,address voter);



 //Event emit when voter cast vote 
       event VoteCast(address indexed voter, address indexed candidateVotedFor);






 // Function for register condidate
     function registerCandidate(address _candidateAddress,string memory _name,string memory _description,uint _age)  public onlyOwner returns (bool){
        require(candidates[_candidateAddress].approved == true, "candidate not approved");
        require(candidates[_candidateAddress].age == 0, "candidate already registered");
        candidates[_candidateAddress].name=_name;
        candidates[_candidateAddress].description=_description;
        candidates[_candidateAddress].age=_age;
      emit candidateRegister(_name,_age,_description,_candidateAddress);   
         return true;
  

     }



// Function for add voters
     function addvoter(address _voterAddress,string memory _name,uint _age) public onlyOwner returns (bool){
        require(!voters[_voterAddress].hasVoted && voters[_voterAddress].age == 0, "Voter already registered");
        voters[_voterAddress].name=_name;
        voters[_voterAddress].age=_age;
     emit VoterRegister(_name,_age,_voterAddress);  
        return true;

     }


  

//Function for vote cast
function voteCast(address _candidateAddress) public  {   
    require(_candidateAddress!=address (0),"invalid candidate");
    require(voters[msg.sender].age!=0, "voter not registtered");
    require(voters[msg.sender].hasVoted==false, "voter already voted");
    voters[msg.sender].hasVoted = true;
    candidates[_candidateAddress].votes++;
      emit  VoteCast(msg.sender, _candidateAddress);

}
       

}






