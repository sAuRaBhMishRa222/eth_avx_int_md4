# Dengen token 

This Solidity contract implements a simple ERC20 token creation system, enabling the owner to mint and manage tokens that comply with the ERC20 standard. The contract features a mint function that allows the owner to create new tokens and assign them to a specified address, ensuring that only the owner can perform this action. The contract also includes a burn function that enables the sender to remove tokens from their balance, and a transfer function that allows users to move tokens between accounts, adhering to the ERC20 protocol. Additionally, the contract provides a redeemToken function that enables users to exchange tokens for in-game items, while logging the redemption event. Furthermore, the contract provides a mechanism for the owner to maintain control over token creation and management, ensuring that tokens are distributed securely and transparently, while also conforming to the widely-adopted ERC20 standard for token implementation.
## Description

This program is a simple contract written in Solidity, a programming language used for developing smart contracts on the Ethereum blockchain. This contract implements a token creation system that adheres to the ERC20 standard, allowing the owner to mint and manage tokens, as well as transfer them between accounts. As an ERC20-compliant token, it includes essential functions such as mint, burn, transfer, and balanceToken, ensuring seamless interaction with other ERC20-compatible contracts and wallets. Additionally, it ensures the integrity of token ownership and maintains a record of token balances, providing a secure and transparent way to manage digital assets on the Ethereum network, while also providing a redeemToken function for users to exchange tokens for in-game items.
## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., myToken.sol). Copy and paste the following code into the file:

```javascript
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
    event Redeemed(address indexed account, string itemName, uint256 amount);

    // Mapping to store the required token amount for each item
    mapping(string => uint256) public itemCosts;

    // Mapping to store redeemed items for each address
    mapping(address => string[]) public redeemedItems;

    // Function to set the cost of an item in DegenTokens
    function setItemCost(string memory itemName, uint256 amount) public onlyOwner {
        itemCosts[itemName] = amount;
    }

    // Function to redeem tokens for in-game items
    function redeemToken(string memory itemName) public {
        uint256 cost = itemCosts[itemName];
        require(cost > 0, "Item does not exist");
        require(balanceOf(msg.sender) >= cost, "Insufficient DegenToken balance to redeem this item");

        // Burn the required tokens
        _burn(msg.sender, cost);

        // Record the redeemed item
        redeemedItems[msg.sender].push(itemName);

        // Emit the redemption event
        emit Redeemed(msg.sender, itemName, cost);
    }

    // Function to mint new tokens
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Function to burn tokens
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    // Function to transfer tokens
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }
    
    // Function to get redeemed items for a specific address
    function getRedeemedItems(address account) public view returns (string[] memory) {
        return redeemedItems[account];
    }
}

```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.26" (or another compatible version), and then click on the "Compile degen.sol" button.

Once the code is compiled, you can tap on environment button and select "Injected Provider - MetaMask" then connect your metamask account to remix id.
After connecting the wallet deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar it will ask for some avax for that , allow it. Select the "degen" contract from the dropdown menu, and then click on the "Deploy" button.

Once the DegenToken contract is deployed, you can interact with it by calling various functions to manage tokens. Click on the deployed DegenToken contract in the left-hand sidebar. To mint new tokens, click on the mint function, pass the required parameters (address to and uint amount), and execute the function to create new tokens and assign them to the specified address, but note that only the owner can execute this function due to the onlyOwner modifier. To burn existing tokens, click on the burn function, pass the required parameter (uint amount), and execute the function to remove tokens from the sender's balance. Alternatively, you can use the redeemToken function to exchange tokens for in-game items, which will also burn the tokens and emit a Redeemed event. To transfer tokens between accounts, click on the transfer function, pass the required parameters (address recipient and uint amount), and execute the function to move tokens from the sender's balance to the recipient's balance. The contract uses require to ensure only the owner can mint tokens, and override to customize the token transfer functionality, ensuring secure and controlled token management.

You can verify your contract using etherscan to check all its functinality and track its all transaction on snowtracer url: https://testnet.snowtrace.io/

## Authors

Saurabh Mishra  


## License

This project is licensed under the MIT License
