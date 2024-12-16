// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Medication {
    struct MedicationData {
        uint id;
        uint patientId;
        string patientName;
        string medInfo;
        bool isActive; // Flag to mark if medication is active or deleted
    }

    mapping(uint => MedicationData) public medications;
    uint public medicationCount;

    event MedicationCreated(uint medicationId);
    event MedicationUpdated(uint medicationId);
    event MedicationDeleted(uint medicationId);

    function createMedication(uint _patientId, string memory _patientName, string memory _medInfo) public {
        medicationCount++;
        medications[medicationCount] = MedicationData(medicationCount, _patientId, _patientName, _medInfo, true);
        emit MedicationCreated(medicationCount);
    }

    function getMedication(uint _id) public view returns (MedicationData memory) {
        require(_id > 0 && _id <= medicationCount, "Invalid medication ID");
        return medications[_id];
    }

    // Update medication details
    function updateMedication(uint _id, string memory _medInfo) public {
        require(_id > 0 && _id <= medicationCount, "Invalid medication ID");
        MedicationData storage med = medications[_id];
        require(med.isActive, "Medication is inactive or deleted");

        med.medInfo = _medInfo;

        emit MedicationUpdated(_id);
    }

    // Delete medication (mark as inactive)
    function deleteMedication(uint _id) public {
        require(_id > 0 && _id <= medicationCount, "Invalid medication ID");
        MedicationData storage med = medications[_id];
        require(med.isActive, "Medication is already deleted");

        med.isActive = false;

        emit MedicationDeleted(_id);
    }
}

