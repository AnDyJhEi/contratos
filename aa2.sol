// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EcoToken is ERC20, Ownable {
    uint256 public constant MAX_SUPPLY = 1_000_000 * (10 ** 18);

    constructor(uint256 initialSupply)
        ERC20("EcoToken", "ECO")
        Ownable(msg.sender) // aquí pasamos el owner
    {
        require(
            initialSupply * (10 ** decimals()) <= MAX_SUPPLY,
            "El supply inicial excede el maximo permitido"
        );
        _mint(msg.sender, initialSupply * (10 ** decimals()));
    }

    function mintTokens(address to, uint256 amount) public onlyOwner {
        require(
            totalSupply() + (amount * (10 ** decimals())) <= MAX_SUPPLY,
            "Supera el maximo permitido"
        );
        _mint(to, amount * (10 ** decimals()));
        emit TokensMinted(to, amount);
    }

    event TokensMinted(address indexed to, uint256 amount);
}

