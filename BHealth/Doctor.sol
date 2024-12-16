// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Doctor {
    struct DoctorData {
        uint id;
        string name;
        string contactNum;
        string email;
        uint clinicId;
        string clinicName;
        uint countPending;
        uint countConfirmed;
        uint countComplete;
        bool isActive; // Flag to mark if doctor is active or deleted
    }

    mapping(uint => DoctorData) public doctors;
    uint public doctorCount;

    event DoctorCreated(uint doctorId);
    event DoctorUpdated(uint doctorId);
    event DoctorDeleted(uint doctorId);

    function createDoctor(
        string memory _name, string memory _contactNum, string memory _email,
        uint _clinicId, string memory _clinicName
    ) public {
        doctorCount++;
        doctors[doctorCount] = DoctorData(
            doctorCount, _name, _contactNum, _email, _clinicId,
            _clinicName, 0, 0, 0, true
        );
        emit DoctorCreated(doctorCount);
    }

    function getDoctor(uint _id) public view returns (DoctorData memory) {
        require(_id > 0 && _id <= doctorCount, "Invalid doctor ID");
        return doctors[_id];
    }

    // Update doctor details
    function updateDoctor(uint _id, string memory _name, string memory _contactNum, string memory _email) public {
        require(_id > 0 && _id <= doctorCount, "Invalid doctor ID");
        DoctorData storage doc = doctors[_id];
        require(doc.isActive, "Doctor is inactive or deleted");

        doc.name = _name;
        doc.contactNum = _contactNum;
        doc.email = _email;

        emit DoctorUpdated(_id);
    }

    // Delete doctor (mark as inactive)
    function deleteDoctor(uint _id) public {
        require(_id > 0 && _id <= doctorCount, "Invalid doctor ID");
        DoctorData storage doc = doctors[_id];
        require(doc.isActive, "Doctor is already deleted");

        doc.isActive = false;

        emit DoctorDeleted(_id);
    }
}
