pragma solidity >=0.4.22 <0.6.0;

contract Bank {
    
    mapping(address => uint256) public savings;
    address public admin;
    
    /*
     * Access Restriction Pattern
     */
    modifier onlyAdmin {
        require(msg.sender == admin);
        _;
    }
    
    constructor (address _admin) public {
        admin = _admin;
    }
    
    /*
     * Pay into a bank account.
     */
    function addSaving(address _to) payable public {
        savings[_to] += msg.value;
    }
    
    /*
     * Take money out of my bank account.
     */
    function takeSaving(uint256 _amount) public {
        require(_amount > 0);
        require(savings[msg.sender] >= _amount);
        msg.sender.transfer(_amount);
        savings[msg.sender] -= _amount;
    }
    
    /*
     * Send ether from my bank account to another one.
     */
    function sendSaving(uint256 _amount, address _to) public {
        require(savings[msg.sender] >= _amount);
        
        savings[msg.sender] -= _amount;
        savings[_to] += _amount;
    }
    
    /*
     * Forcefully takes ether from one account and puts it into another.
     */
    function sendSavingForce(uint256 _amount, address _from, address _to) onlyAdmin public {
        require(savings[_from] >= _amount);
    
        savings[_from] -= _amount;
        savings[_to] += _amount;
    }
}
