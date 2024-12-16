// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Appointment {
    // Struct for storing Appointment data
    struct AppointmentData {
        uint id;
        uint doctorId;
        uint patientId;
        string doctorName;
        string patientName;
        string doctorContactNum;
        string patientContactNum;
        uint scheduledDateTime;  // Unix timestamp
        string status;  // Status can be 'pending', 'confirmed', 'completed', etc.
        string remarks; // Any notes or remarks
        bool isActive; // Flag to mark if appointment is active or deleted
    }

    // Mappings to store appointments by ID
    mapping(uint => AppointmentData) public appointments;
    uint public appointmentCount;

    // Events to log appointment creation, updates, and deletions
    event AppointmentCreated(uint appointmentId);
    event AppointmentUpdated(uint appointmentId);
    event AppointmentDeleted(uint appointmentId);

    // Function to create an appointment
    function createAppointment(
        uint _doctorId, uint _patientId, 
        string memory _doctorName, string memory _patientName,
        string memory _doctorContactNum, string memory _patientContactNum,
        uint _scheduledDateTime, string memory _status, string memory _remarks
    ) public {
        appointmentCount++;
        appointments[appointmentCount] = AppointmentData(
            appointmentCount, _doctorId, _patientId, _doctorName, _patientName,
            _doctorContactNum, _patientContactNum, _scheduledDateTime, _status,
            _remarks, true
        );
        emit AppointmentCreated(appointmentCount);
    }

    // Function to fetch appointment details by ID
    function getAppointment(uint _id) public view returns (AppointmentData memory) {
        require(_id > 0 && _id <= appointmentCount, "Invalid appointment ID");
        return appointments[_id];
    }

    // Function to update an appointment
    function updateAppointment(
        uint _id, uint _scheduledDateTime, string memory _status, string memory _remarks
    ) public {
        require(_id > 0 && _id <= appointmentCount, "Invalid appointment ID");
        AppointmentData storage appointment = appointments[_id];
        require(appointment.isActive, "Appointment is inactive or deleted");

        // Update appointment details
        appointment.scheduledDateTime = _scheduledDateTime;
        appointment.status = _status;
        appointment.remarks = _remarks;

        emit AppointmentUpdated(_id);
    }

    // Function to delete an appointment (mark it as inactive)
    function deleteAppointment(uint _id) public {
        require(_id > 0 && _id <= appointmentCount, "Invalid appointment ID");
        AppointmentData storage appointment = appointments[_id];
        require(appointment.isActive, "Appointment is already deleted");

        // Mark the appointment as inactive
        appointment.isActive = false;

        emit AppointmentDeleted(_id);
    }
}
