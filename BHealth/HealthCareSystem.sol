// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Clinic.sol";
import "./Doctor.sol";
import "./Appointment.sol";
import "./Medication.sol";
import "./Patient.sol";
import "./Visit.sol";

contract HealthCareSystem is Clinic, Doctor, Appointment, Medication, Patient, Visit {

    constructor() {
        // Initialization if needed
    }

    // Additional logic to manage the healthcare system could go here.
}
