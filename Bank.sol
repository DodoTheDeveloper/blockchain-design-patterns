pragma solidity >=0.4.22 <0.6.0;

contract Bank {
    
    mapping(address => uint256) public savings;
    
    constructor () public {}
    
    /*
     * Pay into your bank account.
     */
    function addSaving(address _to) payable public {
        savings[_to] += msg.value;
    }
    
    /*
     * Take money out of the bank.
     */
    function takeSaving(uint256 _amount) public {
        require(_amount > 0);
        require(savings[msg.sender] >= _amount);
        msg.sender.transfer(_amount);
        savings[msg.sender] -= _amount;
    }
    
    /*
     * Send money to another bank account.
     */
    function sendSaving(uint256 _amount, address _from, address _to) public {
        require(savings[_from] >= _amount);
        
        savings[_from] -= _amount;
        savings[_to] += _amount;
    }
    
}
