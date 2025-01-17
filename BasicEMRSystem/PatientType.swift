//
//  PatientType.swift
//  BasicEMRSystem
//
//  Created by Ethan Bell on 12/1/2025.
//
//  This file contains the type Patient- a struct that holds all
//  relevant information for a given patient, including date of birth,
//  name, and other basic information. This struct also stores the blood type
//  and all medications the patient is taking / has taken. Relevant methods
//  are also found in this file, including basic information, medication, and
//  blood type retrieval, but also sorting and calculating functions relevant
//  to compatability and age information retrieval.
//

import Foundation
import SwiftUI

// Used for throwing errors
enum MedicationError: Error {
    case Invalid
    case Duplicate
}



struct Patient: Identifiable, Hashable, CustomStringConvertible {
    let id = UUID()
    var description: String {
        return "MRN: \(MRN), First Name: \(firstName), Last Name: \(lastName), DOB: \(DOB), Height: \(height), Weight: \(weight), Blood Type: \(bloodType.typeBlood), Medications: \(medications)"
    }
    var MRN: Int
    var firstName: String
    var lastName: String
    var DOB: DOB
    var height: Int
    var weight: Int
    var bloodType: BloodType
    var medications: [Medication]
    
    init(description: String = "", MRN: Int = 0, firstName: String = "Unknown", lastName: String = "Unknown", DOB: DOB, height: Int = 0, weight: Int = 0, bloodType: BloodType, medications: [Medication] = []) {
        self.MRN = Int.random(in: 10000...99999)
        self.firstName = firstName
        self.lastName = lastName
        self.DOB = DOB
        self.height = height
        self.weight = weight
        self.bloodType = bloodType
        self.medications = medications
    }
    
    func calculateInitials() -> String {
        let firstInitial = firstName.first?.uppercased() ?? "?"
        let lastInitial = lastName.first?.uppercased() ?? "?"
        return "\(firstInitial)\(lastInitial)"
    }
    
    // This function returns basic info (Assignment method #1)
    func basicInfo() -> String {
        return "\(lastName), \(firstName), (\(DOB.calculateAge()) years)"
    }
    
    // This function returns expanded basic info
    func allInfo() -> String {
        return "\(basicInfo()), \(height) cm, \(weight) kg, Blood type: \(bloodType.typeBlood)"
    }
    
    // This function returns a sorted list of active medications being taken
    // by the patient (Assignment method #2)
    func medicationInfo() -> [String] {
        var medicationList: [Medication] = []
        var sortedMedication: [String] = []
        if medications.isEmpty {
            return ["No medications"]
        }
        for Medication in medications {
            // Only add to list if the medication cycle is not yet completed
            if Medication.calculateCompleted() == 0 {
                medicationList.append(Medication)
            }
        }
        // sorting functionality - used Swift guide "Closures" and understanding of
        // DateComponents type
        // Pass the DateComponents to Date type and compare the prescription dates
        // of each given medication, setting older dates higher. Use of "!" was recommended by XCode, allows for handling the empty case.
        let sortedList = medicationList.sorted(by: { Calendar.current.date(from: $0.datePrescribed)! < Calendar.current.date(from:$1.datePrescribed)! })
        for Medication in sortedList {
            sortedMedication.append("\(Medication.name) (Prescribed on \(Medication.datePrescribed))")
        }
        print(sortedMedication)
        return sortedMedication
    }
    
    // This function checks for duplicate medications
    func checkForDuplicates( med: Medication) -> Bool {
        // Loop through the array to determine if there are any duplicates
        for medication in medications {
            if medication.name == med.name {
                return true
            }
        }
        return false
    }
    
    // This function prescribes medication to a patient - use of mutating
    // func recommended by XCode (Assignment method #3), "throws" used for
    // throwing an error.
    mutating func prescribeMedication( med: Medication) throws -> String {
        // If duplicate, throw error and do not append to medications array
        if checkForDuplicates(med: med) == true {
            throw MedicationError.Duplicate
        } else {
            medications.append(med)
        }
        return "\(med.name) Prescribed"
    }
    
    // This function returns the blood type of the patient
    func bloodTypeInfo() -> String {
        return "\(firstName) \(lastName)'s blood type is: \(bloodType.typeBlood)"
    }
    
    // This function returns compatible blood types for
    // the patient (Bonus method)
    func compatibleBloodType() -> [String] {
        var compatibleTypes: [String] = []
        if bloodType.typeBlood == "O-" {
            compatibleTypes.append("O-")
        }
        if bloodType.typeBlood == "O+" {
            compatibleTypes.append("O-")
            compatibleTypes.append("O+")
        }
        if bloodType.typeBlood == "B-" {
            compatibleTypes.append("O-")
            compatibleTypes.append("B-")
        }
        if bloodType.typeBlood == "B+" {
            compatibleTypes.append("O-")
            compatibleTypes.append("O+")
            compatibleTypes.append("B-")
            compatibleTypes.append("B+")
        }
        if bloodType.typeBlood == "A-" {
            compatibleTypes.append("O-")
            compatibleTypes.append("A-")
        }
        if bloodType.typeBlood == "A+" {
            compatibleTypes.append("O-")
            compatibleTypes.append("O+")
            compatibleTypes.append("A-")
            compatibleTypes.append("A+")
        }
        if bloodType.typeBlood == ("AB-") {
            compatibleTypes.append("O-")
            compatibleTypes.append("B-")
            compatibleTypes.append("A-")
            compatibleTypes.append("AB-")
        }
        if bloodType.typeBlood == ("AB+") {
            compatibleTypes.append("O-")
            compatibleTypes.append("O+")
            compatibleTypes.append("B-")
            compatibleTypes.append("B+")
            compatibleTypes.append("A-")
            compatibleTypes.append("A+")
            compatibleTypes.append("AB-")
            compatibleTypes.append("AB+")
        }
        return compatibleTypes
    }
    
    // This function returns the list of completed
    // medications, alongside the date of completion
    func completedMedication() -> [String] {
        var completedList: [String] = []
        for medication in medications {
            // only add to array if it is completed
            if medication.calculateCompleted() == 1 {
                completedList.append("\(medication.name), Completed on \(medication.calculateCompletedDay())")
            }
        }
        return completedList
    }
}
