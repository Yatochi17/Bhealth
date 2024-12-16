// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Medication {
    struct MedicationData {
        uint id;
        uint patientId;
        string patientName;
        string medInfo;
    }

    mapping(uint => MedicationData) public medications;
    uint public medicationCount;

    event MedicationAdded(uint medicationId, uint patientId);

    function addMedication(uint _patientId, string memory _patientName, string memory _medInfo) public {
        medicationCount++;
        medications[medicationCount] = MedicationData(medicationCount, _patientId, _patientName, _medInfo);
        emit MedicationAdded(medicationCount, _patientId);
    }

    function getMedication(uint _id) public view returns (MedicationData memory) {
        require(_id > 0 && _id <= medicationCount, "Invalid medication ID");
        return medications[_id];
    }
}
