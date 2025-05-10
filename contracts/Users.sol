    // SPDX-License-Identifier: MIT
    pragma solidity >=0.8.2 <0.9.0;

    contract SampleContract {
        uint value;
        
        struct User {
            string name;
            string surname;
        }

        struct Product {

            string name;
            string description;
            address creator;
            uint256 createdTime;
            string picURL;
        }

        Product[] public products;

        function createProduct(string memory _name, string memory _description,string memory _picURL) public {
            products.push(Product({
                name: _name,    
                description: _description,
                creator: msg.sender,
                createdTime: block.timestamp,
                picURL: _picURL
            }));
        }
        
        User[] public users;
        
        constructor() {
            users.push(User("Tom", "Due"));
            users.push(User("Joe", "Barbaro"));
        }
        
        function setValue(uint _value) public {
            value = _value;
        }
        
        function getValue() public view returns(uint) {
            return value;
        }
        
        function getUserCount() public view returns(uint) {
            return users.length;
        }
        
        function getUser(uint index) public view returns(string memory, string memory) {
            require(index < users.length, "User does not exist");
            User memory user = users[index];
            return (user.name, user.surname);
        }

        function getProductCount() public view returns(uint) {
            return  products.length;
        }

        function getProduct(uint index) public view returns (string memory name, string memory desc, string memory imageURL){

            return (products[index].name, products[index].description, products[index].picURL);
        }
    }