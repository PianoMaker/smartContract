// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Shop {

    struct Product {
        string name;   
        uint256 price; 
    }


    Product[] private products;

    
    function addProduct(string memory name, uint256 price) public {
        require(price > 0, "Price must be greater than zero.");
        products.push(Product(name, price));
    }


    function buyProduct(uint256 productId) public payable {
        require(productId < products.length, "Product does not exist.");
        
        Product memory product = products[productId];
        require(msg.value >= product.price, "Insufficient funds.");


        if (msg.value > product.price) {
            payable(msg.sender).transfer(msg.value - product.price);
        }


    }


    function getProducts() public view returns (Product[] memory) {
        return products;
    }
}
