// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Clinic {
    struct ClinicData {
        uint id;
        string name;
        string contactNum;
        string location;
        uint countDoctors;
        bool isActive; // Flag to mark if clinic is active or deleted
    }

    mapping(uint => ClinicData) public clinics;
    uint public clinicCount;

    event ClinicCreated(uint clinicId);
    event ClinicUpdated(uint clinicId);
    event ClinicDeleted(uint clinicId);

    function createClinic(
        string memory _name, string memory _contactNum, string memory _location
    ) public {
        clinicCount++;
        clinics[clinicCount] = ClinicData(clinicCount, _name, _contactNum, _location, 0, true);
        emit ClinicCreated(clinicCount);
    }

    function getClinic(uint _id) public view returns (ClinicData memory) {
        require(_id > 0 && _id <= clinicCount, "Invalid clinic ID");
        return clinics[_id];
    }

    // Update clinic details
    function updateClinic(uint _id, string memory _name, string memory _contactNum, string memory _location) public {
        require(_id > 0 && _id <= clinicCount, "Invalid clinic ID");
        ClinicData storage clinic = clinics[_id];
        require(clinic.isActive, "Clinic is inactive or deleted");

        clinic.name = _name;
        clinic.contactNum = _contactNum;
        clinic.location = _location;

        emit ClinicUpdated(_id);
    }

    // Delete clinic (mark as inactive)
    function deleteClinic(uint _id) public {
        require(_id > 0 && _id <= clinicCount, "Invalid clinic ID");
        ClinicData storage clinic = clinics[_id];
        require(clinic.isActive, "Clinic is already deleted");

        clinic.isActive = false;

        emit ClinicDeleted(_id);
    }
}
