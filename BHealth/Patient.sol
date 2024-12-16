// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Patient {
    struct PatientData {
        uint id;
        string name;
        string contactNum;
        uint lastVisit;
        bool isActive; // Flag to mark if patient is active or deleted
    }

    mapping(uint => PatientData) public patients;
    uint public patientCount;

    event PatientCreated(uint patientId);
    event PatientUpdated(uint patientId);
    event PatientDeleted(uint patientId);

    function createPatient(string memory _name, string memory _contactNum) public {
        patientCount++;
        patients[patientCount] = PatientData(patientCount, _name, _contactNum, block.timestamp, true);
        emit PatientCreated(patientCount);
    }

    function getPatient(uint _id) public view returns (PatientData memory) {
        require(_id > 0 && _id <= patientCount, "Invalid patient ID");
        return patients[_id];
    }

    // Update an existing patient
    function updatePatient(uint _id, string memory _name, string memory _contactNum) public {
        require(_id > 0 && _id <= patientCount, "Invalid patient ID");
        PatientData storage patient = patients[_id];
        require(patient.isActive, "Patient is inactive or deleted");

        patient.name = _name;
        patient.contactNum = _contactNum;

        emit PatientUpdated(_id);
    }

    // Delete a patient (mark as inactive)
    function deletePatient(uint _id) public {
        require(_id > 0 && _id <= patientCount, "Invalid patient ID");
        PatientData storage patient = patients[_id];
        require(patient.isActive, "Patient is already deleted");

        patient.isActive = false;

        emit PatientDeleted(_id);
    }
}

