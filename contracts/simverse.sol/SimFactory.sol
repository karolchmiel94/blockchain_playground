// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10 <0.9.0;

import "@openzeppelin/contracts/ownership/Ownable.sol";

contract SimFactory is Ownable {
    event NewSim(uint256 simId, string name, uint256 dna);

    uint256 private dnaDigits = 16;
    uint256 private dnaModulus = 10**dnaDigits;

    struct Sim {
        string name;
        uint128 dna;
        uint16 strength;
        uint16 perception;
        uint16 endurance;
        uint16 charisma;
        uint16 intelligence;
        uint16 agility;
        uint16 luck;
        uint16 level;
        uint256 readyTime;
    }

    Sim[] public sims;

    function createRandomSim(string _name) public {
        uint256 randDna = _generateRandomDna(_name);
        _createSim(_name, randDna);
    }

    function _createSim(string _name, uint256 _dna) private {
        uint256 id = sims.push(Sim(_name, _dna)) - 1;
        emit NewSim(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint256) {
        uint256 rand = uint256(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }
}
