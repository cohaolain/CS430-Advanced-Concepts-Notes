// © Ciarán Ó hAoláin 2020
// Shopping List Smart Contract
pragma solidity ^0.6.0;

contract ShoppingList {
    mapping (string => uint) public counter;
    string[] public keys;
    
    address public owner;
    
    // Any function with this modifier will run the "require" first,
    // before running the rest of the originally called function in
    // place of the "_;".
    modifier onlyOwner {
        // Transaction reverts if require argument evaluates to false
        require (owner == msg.sender);
        _;
    }
    
    // Just to keep track of who created the contract - only they
    // will be able to "clear" the shopping list, essentially
    // saying they've bought everything.
    constructor() public {
        owner = msg.sender;
    }
    
    // Anybody can call this function, and by doing so, add to the list.
    // Writing "string memory" as opposed to "string" is related to how
    // dynamically sized objects work in Solidity.
    function increment(string memory key, uint amount) public returns (bool success) {
        counter[key] += amount;
        keys.push(key);
        success = true;
    }
    
    // Only the owner can mark the list completed. This resets the counters
    // to zero.
    function markCompleted() public onlyOwner returns (bool success) {
        while (keys.length > 0) {
            counter[keys[keys.length - 1]] = 0;
            keys.pop();
        }
        success = true;
    }
    
    // As an example of a "view" function
    // Notice how it doesn't modify anything.
    function getFirstAddedItemCurrentAmount() public view returns (string memory key, uint amount) {
        if (keys.length > 0) {
            key = keys[0];
            amount = counter[key];
        } else {
            key = "N/A";
        }
    }
    
    // And a pure function (originally called constant functions)
    // Notice how the result doesn't even depend on anything stored in the contract.
    // Coolest thing about this is that "number" can be stupidly big. 256 bits, unsigned.
    function thisIsSoPure(uint number) public pure returns (uint anotherNumber) {
        // Returns can also be written like this
        return (number * 2) + 5;
    }
    
}

