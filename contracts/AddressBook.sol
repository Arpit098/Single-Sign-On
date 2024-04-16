// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract AddressBook {
    struct Person {
        string name;
        uint256 phoneNumber;
        string email;
        bytes32 passwordHash; // Store the hash of the password
        string pictureURL;
    }
    
    mapping(address => Person) private addressBook;

    event NewPersonAdded(address indexed walletAddress, string name, string pictureURL);

    function addPerson(string memory _name, uint256 _phoneNumber, string memory _email, string memory _password, string memory _pictureURL) public {
        address sender = msg.sender;
        require(bytes(_name).length > 0, "Name must not be empty");
        require(_phoneNumber > 0, "Phone number must be valid");
        require(bytes(_email).length > 0, "Email must not be empty");
        require(bytes(_password).length > 0, "Password must not be empty");
        require(bytes(_pictureURL).length > 0, "Picture URL must not be empty");

        bytes32 passwordHash = hashPassword(_password);

        addressBook[sender] = Person(_name, _phoneNumber, _email, passwordHash, _pictureURL);
        emit NewPersonAdded(sender, _name, _pictureURL);
    }

    function getPersonDetails(string memory _password, uint8 _accessLevel) public view returns (string memory name, string memory pictureURL, string memory email, uint256 phoneNumber) {
        require(_accessLevel >= 1 && _accessLevel <= 3, "Invalid access level");

        Person memory person = addressBook[msg.sender];
        bytes32 hashedPassword = hashPassword(_password);
        require(person.passwordHash == hashedPassword, "Incorrect password");

        if (_accessLevel == 1) {
            return (person.name, person.pictureURL, "", 0);
        } else if (_accessLevel == 2) {
            return (person.name, person.pictureURL, person.email, 0);
        } else {
            return (person.name, person.pictureURL, person.email, person.phoneNumber);
        }
    }

    function hashPassword(string memory _password) private pure returns (bytes32) {
        return keccak256(abi.encodePacked(_password));
    }
}
