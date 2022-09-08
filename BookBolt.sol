// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Calculator {

    string public bolt;
    bool public paid;
    uint public pricePaid;
    address public boltDriverAddress;
    string public carType;

    bool userPaid;

    address payable driverWallet;
    uint public boltPrice;
    
    enum Bolt {
        Avalable,
        Unavaleble
    }
    Bolt currentStatus;

    constructor() {
        currentStatus = Bolt.Avalable;
        driverWallet = payable(0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB);
        boltPrice = 5 ether;
    }

    modifier onlyWhileAvalable {
        require(currentStatus == Bolt.Avalable, "There is no Bolt Avalable");
        _;
    }

    function bookBolt() payable public onlyWhileAvalable {
        if (msg.value >= boltPrice) {
            userPaid = true;
            pricePaid = msg.value;
        } else if(msg.value < boltPrice) {
            userPaid = false;
            bolt = "You paid less :(";
        }
    }

    function boltDetails() public {
        if (userPaid == true) {
            currentStatus = Bolt.Unavaleble;
            carType = "Toyota";
            paid = true;
            bolt = "Your Bolt is on it's way :)";

        } else {
            carType = "Toyota";
            boltDriverAddress = driverWallet;
            paid = false;
            bolt = "Order a Bolt ):";
        }
    }
}