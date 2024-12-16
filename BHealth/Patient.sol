// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Patient {
    struct PatientData {
        uint id;
        string patientName;
        string patContactNum;
        uint lastVisit;
    }

    mapping(uint => PatientData) public patients;
    uint public patientCount;

    event PatientAdded(uint patientId, string patientName);

    function addPatient(string memory _patientName, string memory _patContactNum, uint _lastVisit) public {
        patientCount++;
        patients[patientCount] = PatientData(patientCount, _patientName, _patContactNum, _lastVisit);
        emit PatientAdded(patientCount, _patientName);
    }

    function getPatient(uint _id) public view returns (PatientData memory) {
        require(_id > 0 && _id <= patientCount, "Invalid patient ID");
        return patients[_id];
    }
}
