// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Clinic.sol";  // Import Clinic contract
import "./Patient.sol";  // Import Patient contract
import "./Medication.sol";  // Import Medication contract

contract Visit {
    struct VisitData {
        uint id;
        uint visitDateTime;
        string visitType;
        uint clinicId;
        uint patientId;
        string clinicName;
        string patientName;
        string medInfo;
        string doctorRemarks;
        bool isActive; // Flag to check if the visit is active or deleted
    }

    mapping(uint => VisitData) public visits;
    uint public visitCount;

    event VisitCreated(uint visitId, uint clinicId, uint patientId, uint visitDateTime);
    event VisitUpdated(uint visitId);
    event VisitDeleted(uint visitId);

    function createVisit(
        uint _clinicId, uint _patientId, uint _visitDateTime,
        string memory _visitType, string memory _clinicName,
        string memory _patientName, string memory _medInfo, string memory _doctorRemarks
    ) public {
        visitCount++;
        visits[visitCount] = VisitData(
            visitCount, _visitDateTime, _visitType, _clinicId, _patientId,
            _clinicName, _patientName, _medInfo, _doctorRemarks, true
        );
        emit VisitCreated(visitCount, _clinicId, _patientId, _visitDateTime);
    }

    function getVisit(uint _id) public view returns (VisitData memory) {
        require(_id > 0 && _id <= visitCount, "Invalid visit ID");
        return visits[_id];
    }

    // Update an existing visit
    function updateVisit(
        uint _id, uint _visitDateTime, string memory _visitType,
        string memory _clinicName, string memory _patientName,
        string memory _medInfo, string memory _doctorRemarks
    ) public {
        require(_id > 0 && _id <= visitCount, "Invalid visit ID");
        VisitData storage visit = visits[_id];
        require(visit.isActive, "Visit is inactive or deleted");

        visit.visitDateTime = _visitDateTime;
        visit.visitType = _visitType;
        visit.clinicName = _clinicName;
        visit.patientName = _patientName;
        visit.medInfo = _medInfo;
        visit.doctorRemarks = _doctorRemarks;

        emit VisitUpdated(_id);
    }

    // Delete a visit (mark it as inactive)
    function deleteVisit(uint _id) public {
        require(_id > 0 && _id <= visitCount, "Invalid visit ID");
        VisitData storage visit = visits[_id];
        require(visit.isActive, "Visit is already deleted");

        visit.isActive = false;

        emit VisitDeleted(_id);
    }
}

