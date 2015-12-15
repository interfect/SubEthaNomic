/*
This creates a basic nomic.

There is a list of addresses that are "players", holding 1 unit of citizenship.

Motions can be proposed by any player.

Motions can be rejected by any player, or passed unanimously.
*/

contract Nomic { 
    struct Proposal {
        string description; /* What is the proposal? */
        string ipfsHash; /* If the proposal is too long to include inline */
        bool isUpgrade; /* Should the passage of this proposal replace this contract with a new one? */
        address upgradeAddress; /* Address to suicide to. This becomes the new game contract. Game state should have been copied. */
        bool proposalPassed; /* Has the proposal passed? */
        bool proposalFailed; /* Has the proposal failed? */
        uint32 numberOfVotes; /* Affirmative votes */
        mapping (address => bool) voted; /* Who has voted? */
    }
    
    /* Public variables of the citizenship token */
    string public name;
    string public symbol;
    
    /* How many citizenships does everyone have? */
    mapping (address => bool) public isPlaying;
    
    /* How many players are playing? */
    uint32 public totalPlayers;
    
    /* Is the contract in setup mode (founder can add players) */
    bool public isSetup;
    address public founder;
    
    /* Keep all proposals ever */
    Proposal[] public proposals;

    /* This generates a public event on the blockchain that will notify clients */
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    /* These are for proposals */
    event ProposalAdded(uint proposalID, string description, string ipfsHash, bool isUpgrade, address upgradeAddress);
    event Voted(uint proposalID, address voter, bool position);
    event ProposalClosed(uint proposalID, bool passed);
    
    
    
    /* Initializes contract with initial supply tokens to the creator of the contract */
    function Nomic(string _name, string _symbol) {
        /* Set up the game */
        name = _name;     
        symbol = _symbol;
        
        /* Original set-up-er is the only player so far. */
        isPlaying[msg.sender] = true;
        totalPlayers = 1;
        
        /* In setup mode, founder can add players unilaterally. */
        founder = msg.sender;
        isSetup = true;
    }
    
    /* Fulfil the normal token API */
    function totalSupply() constant returns (uint256 supply) {
        supply = totalPlayers;
    }
    
    function balanceOf(address _address) constant returns (uint256 balance) {
        if(isPlaying[_address]) {
            balance = 1;
        } else {
            balance = 0;
        }
    }
    
    function transfer(address _to, uint256 _value) returns (bool _success) {
        if (!isPlaying[msg.sender] || _value != 1) {
            _success = false;
        } else {
            isPlaying[msg.sender] = false;
            isPlaying[_to] = true;
            
            /* Notifiy anyone listening that this transfer took place */
            Transfer(msg.sender, _to, _value);
            
            _success = true;
        }
    }
    
    /* Add players */
    function addPlayer(address _address) {
        if(msg.sender != founder) throw;
        if(!isSetup) throw;
        
        totalPlayers += 1;
        isPlaying[_address] = true;
    }
    
    /* Remove players */
    function removePlayer(address _address) {
        if(msg.sender != founder) throw;
        if(!isSetup) throw;
        
        if(!isPlaying[_address]) throw;
        
        totalPlayers -= 1;
        isPlaying[_address] = false;
    }
    
    /* Leave setup mode */
    function startGame() {
        if(msg.sender != founder) throw;
        if(!isSetup) throw;
        
        isSetup = false;
    }
    
    /* modifier that allows only shareholders to vote and create new proposals */
    modifier onlyPlayers {
        if (isSetup) throw;
        if (!isPlaying[msg.sender]) throw;
        _
    }
    
    /* Add a proposal */
    function newProposal(string _description, string _ipfsHash, bool _isUpgrade, address _upgradeAddress) onlyPlayers returns (uint proposalID) {
        proposalID = proposals.length++;
        Proposal p = proposals[proposalID];
        p.description = _description;
        p.ipfsHash = _ipfsHash;
        p.isUpgrade = _isUpgrade;
        p.upgradeAddress = _upgradeAddress;
        p.proposalPassed = false;
        p.proposalFailed = false;
        p.numberOfVotes = 0;
        ProposalAdded(proposalID, _description, _ipfsHash, _isUpgrade, _upgradeAddress);
    }
    
    /* Vote for or against a proposal. */
    function vote(uint proposalNumber, bool supportsProposal) onlyPlayers {
        Proposal p = proposals[proposalNumber];
        if (p.voted[msg.sender] == true) throw;
        if (p.proposalPassed) throw;
        if (p.proposalFailed) throw;
        
        p.voted[msg.sender] = true;
        Voted(proposalNumber, msg.sender, supportsProposal);
        
        if(supportsProposal) {
            p.numberOfVotes += 1;
        } else {
            p.proposalFailed = true;
            ProposalClosed(proposalNumber, false);
        }
    }
    
    function executeProposal(uint proposalNumber) onlyPlayers {
        Proposal p = proposals[proposalNumber];
        
        if (p.proposalFailed) throw;
        if (p.proposalPassed) throw;
        if (p.numberOfVotes < totalPlayers) throw;
        
        p.proposalPassed = true;
        
        /* Fire Events */
        ProposalClosed(proposalNumber, true);
        
        if(p.isUpgrade) {
            /* Send any money we have to the upgrade contract. */
            suicide(p.upgradeAddress);
        }
    }
    
    
}            