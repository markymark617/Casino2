pragma solidity ^0.5.0;

contract AccessController {

    address public ceoAddress;
    address public workerAddress;
    address[] workerAddresses; 

    event CEOSet(address newCEO);
    event WorkerSet(address newWorker);


    constructor() public {
        ceoAddress = msg.sender;
        workerAddress = msg.sender;
        emit CEOSet(ceoAddress);
        emit WorkerSet(workerAddress);
    }

    modifier onlyCEO() {
        require(msg.sender == ceoAddress,
            'AccessControl: CEO access denied');
        _;
    }

    modifier onlyWorker() {
        bool isWorker;
        for(uint i=0; i < workerAddresses.length;i++) {
             if(msg.sender == workerAddresses[i]) {
                isWorker=true;
             }
        }            
        require(isWorker,
        'AccessControl: worker access denied');
        _;
    }

    function setCEO(address _newCEO) public onlyCEO {
        require(
            _newCEO != address(0x0),
            'AccessControl: invalid CEO address'
        );
        ceoAddress = _newCEO;
        emit CEOSet(ceoAddress);
    }

    function setWorker(address _newWorker) external {
        require(
            _newWorker != address(0x0),
            'AccessControl: invalid worker address'
        );
        require(
            msg.sender == ceoAddress || msg.sender == workerAddress,
            'AccessControl: invalid worker address'
        );
        workerAddress = _newWorker;
        emit WorkerSet(workerAddress);
    }

}