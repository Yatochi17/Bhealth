// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Clinic.sol";  // Import Clinic contract

contract Doctor {
    struct DoctorData {
        uint id;
        string doctorName;
        string docContactNum;
        string docEmail;
        uint clinicId;
        uint countPending;
        uint countConfirmed;
        uint countComplete;
    }

    mapping(uint => DoctorData) public doctors;
    uint public doctorCount;

    event DoctorAdded(uint doctorId, string doctorName, uint clinicId);

    function addDoctor(string memory _doctorName, string memory _docContactNum, string memory _docEmail, uint _clinicId) public {
        doctorCount++;
        doctors[doctorCount] = DoctorData(doctorCount, _doctorName, _docContactNum, _docEmail, _clinicId, 0, 0, 0);
        emit DoctorAdded(doctorCount, _doctorName, _clinicId);
    }

    function getDoctor(uint _id) public view returns (DoctorData memory) {
        require(_id > 0 && _id <= doctorCount, "Invalid doctor ID");
        return doctors[_id];
    }
}
