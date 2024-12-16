// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Doctor.sol";  // Import Doctor contract
import "./Patient.sol";  // Import Patient contract

contract Appointment {
    struct AppointmentData {
        uint id;
        uint doctorId;
        uint patientId;
        string doctorName;
        string patientName;
        string docContactNum;
        string patContactNum;
        uint scheduledDateTime;
        string status;
        string remarks;
    }

    mapping(uint => AppointmentData) public appointments;
    uint public appointmentCount;

    event AppointmentCreated(uint appointmentId, uint doctorId, uint patientId, uint scheduledDateTime);

    function createAppointment(
        uint _doctorId, uint _patientId,
        uint _scheduledDateTime, string memory _status,
        string memory _remarks
    ) public {
        appointmentCount++;
        AppointmentData memory newAppointment = AppointmentData(
            appointmentCount, _doctorId, _patientId,
            "Doctor Name", "Patient Name", "Doctor Contact", "Patient Contact", _scheduledDateTime, _status, _remarks
        );
        appointments[appointmentCount] = newAppointment;
        emit AppointmentCreated(appointmentCount, _doctorId, _patientId, _scheduledDateTime);
    }

    function getAppointment(uint _id) public view returns (AppointmentData memory) {
        require(_id > 0 && _id <= appointmentCount, "Invalid appointment ID");
        return appointments[_id];
    }
}
