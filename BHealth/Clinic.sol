// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Clinic {
    struct ClinicData {
        uint id;
        string clinicName;
        string clinicContactNum;
        string location;
        uint countDoctors;
    }

    mapping(uint => ClinicData) public clinics;
    uint public clinicCount;

    event ClinicAdded(uint clinicId, string clinicName);

    function addClinic(string memory _clinicName, string memory _clinicContactNum, string memory _location) public {
        clinicCount++;
        clinics[clinicCount] = ClinicData(clinicCount, _clinicName, _clinicContactNum, _location, 0);
        emit ClinicAdded(clinicCount, _clinicName);
    }

    function getClinic(uint _id) public view returns (ClinicData memory) {
        require(_id > 0 && _id <= clinicCount, "Invalid clinic ID");
        return clinics[_id];
    }
}
