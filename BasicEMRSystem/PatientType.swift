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
    case Duplicate
}

enum dateofBirthError: Error {
    case Invalid
    case FutureDate
}


    struct Patient: Identifiable, Hashable, CustomStringConvertible {
        let id = UUID()
        var description: String {
            return "MRN: \(MRN), First Name: \(firstName), Last Name: \(lastName), Date of Birth: \(dateOfBirth), Height: \(height), Weight: \(weight), Blood Type: \(bloodType?.typeBlood.rawValue ?? "Unknown"), Medications: \(medications)"
        }
        var MRN = UUID()
        let firstName: String
        let lastName: String
        let dateOfBirth: DateComponents
        let height: HeightWeight
        let weight: HeightWeight
        let bloodType: BloodType?
        var medications: [Medication]
        
        init(firstName: String, lastName: String, dateOfBirth: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date()), height: HeightWeight, weight: HeightWeight, bloodType: BloodType? = nil, medications: [Medication] = []) {
            self.firstName = firstName
            self.lastName = lastName
            self.dateOfBirth = dateOfBirth
            self.height = height
            self.weight = weight
            self.bloodType = bloodType ?? BloodType()
            self.medications = medications
        }
    
    func calculateInitials() -> String {
        let firstInitial = firstName.first?.uppercased() ?? "?"
        let lastInitial = lastName.first?.uppercased() ?? "?"
        return "\(firstInitial)\(lastInitial)"
    }
        
        
    // moved dateOfBirth out of its own struct and into Patient
    func calculateAge() throws -> Int {
        guard let birthDate = Calendar.current.date(from: dateOfBirth) else {
            throw dateofBirthError.Invalid
        }
        let today = Date()
        if birthDate > today {
            throw dateofBirthError.FutureDate
        }
        // takes in the year difference between the birthdate and todays date,
        // which allows for age calculation.
        let ageDate = Calendar.current.dateComponents([.year, .month, .day], from: birthDate, to: today)
        if let ageYear = ageDate.year, let ageMonth = ageDate.month, let ageDay = ageDate.day {
            if ageMonth < 0 || ageMonth == 0 && ageDay < 0 {
                return ageYear - 1
            } else {
                return ageYear
            }
        }
        return 0
    }
    
    func makeDigestible() -> String {
        return "\(dateOfBirth.month ?? 0)/\(dateOfBirth.day ?? 0)/\(dateOfBirth.year ?? 0)"
    }
    
    // This function returns basic info (Assignment method #1)
    func basicInfo() -> String {
        do {
            let age = try calculateAge()
            return "\(lastName), \(firstName), (\(age) years)"
        } catch dateofBirthError.FutureDate {
            return "\(lastName), \(firstName), (Invalid Birthdate: future date)"
        } catch dateofBirthError.Invalid {
            return "\(lastName), \(firstName), (Invalid Birthdate)"
        } catch {
            return "\(lastName), \(firstName), (Unknown Error)"
        }

    }
    
    // This function returns expanded basic info
    func allInfo() -> String {
        return "\(basicInfo()), \(height), \(weight), Blood type: \(bloodType?.typeBlood.rawValue ?? "Unknown")"
    }
    
    // This function returns a sorted list of active medications being taken
    // by the patient (Assignment method #2)
        func medicationInfo() -> [Medication] {
        var medicationList: [Medication] = []
        var sortedMedication: [Medication] = []
        if medications.isEmpty {
            return []
        }
        for Medication in medications {
            // Only add to list if the medication cycle is not yet completed
            if Medication.calculateCompleted() == false {
                medicationList.append(Medication)
            }
        }
        // sorting functionality - used Swift guide "Closures" and understanding of
        // DateComponents type
        // Pass the DateComponents to Date type and compare the prescription dates
        // of each given medication, setting older dates higher. Use of "!" was recommended by XCode, allows for handling the empty case.
        let sortedList = medicationList.sorted(by: { Calendar.current.date(from: $0.datePrescribed)! < Calendar.current.date(from:$1.datePrescribed)! })
        for Medication in sortedList {
            sortedMedication.append(Medication)
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
        return "\(firstName) \(lastName)'s blood type is: \(bloodType?.typeBlood.rawValue ?? "Unknown")"
    }
    
    // This function returns compatible blood types for
    // the patient (Bonus method)
    func compatibleBloodType() -> [String] {
        var compatibleTypes: [String] = []
        if bloodType?.typeBlood.rawValue == "O-" {
            compatibleTypes.append("O-")
        }
        if bloodType?.typeBlood.rawValue == "O+" {
            compatibleTypes.append("O-")
            compatibleTypes.append("O+")
        }
        if bloodType?.typeBlood.rawValue == "B-" {
            compatibleTypes.append("O-")
            compatibleTypes.append("B-")
        }
        if bloodType?.typeBlood.rawValue == "B+" {
            compatibleTypes.append("O-")
            compatibleTypes.append("O+")
            compatibleTypes.append("B-")
            compatibleTypes.append("B+")
        }
        if bloodType?.typeBlood.rawValue == "A-" {
            compatibleTypes.append("O-")
            compatibleTypes.append("A-")
        }
        if bloodType?.typeBlood.rawValue == "A+" {
            compatibleTypes.append("O-")
            compatibleTypes.append("O+")
            compatibleTypes.append("A-")
            compatibleTypes.append("A+")
        }
        if bloodType?.typeBlood.rawValue == ("AB-") {
            compatibleTypes.append("O-")
            compatibleTypes.append("B-")
            compatibleTypes.append("A-")
            compatibleTypes.append("AB-")
        }
        if bloodType?.typeBlood.rawValue == ("AB+") {
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
            if medication.calculateCompleted() == true {
                completedList.append("\(medication.name), Completed on \(medication.calculateCompletedDay())")
            }
        }
        return completedList
    }
}
