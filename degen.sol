// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DegenToken is ERC20 {

    address public owner;

    constructor() ERC20("Degen", "DGN") {
        owner = msg.sender;
    }

    // Modifier to restrict access to owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    // Event to log token redemptions
    event Redeemed(address indexed account, uint256 amount);

    // Function to mint new tokens
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Function to burn tokens
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    // Function to redeem tokens for in-game items
    function redeemToken(uint256 amount) public {
        _burn(msg.sender, amount);
        emit Redeemed(msg.sender, amount);
    }

    //Function to transfer tokens
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }


    //Function to check the total available tokens
    function balanceToken(address account) public view returns (uint256) {
    return super.balanceOf(account);
    }

}
