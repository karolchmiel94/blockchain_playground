// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10 <0.9.0;

contract SimFactory {
    event NewSim(uint256 simId, string name, uint256 dna);

    uint256 private dnaDigits = 16;
    uint256 private dnaModulus = 10**dnaDigits;

    struct Sim {
        string name;
        uint256 dna;
    }

    Sim[] public Sims;

    function _createSim(string _name, uint256 _dna) private {
        uint256 id = Sims.push(Sim(_name, _dna)) - 1;
        emit NewSim(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint256) {
        uint256 rand = uint256(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomSim(string _name) public {
        uint256 randDna = _generateRandomDna(_name);
        _createSim(_name, randDna);
    }
}
