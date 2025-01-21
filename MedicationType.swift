//
//  MedicationType.swift
//  BasicEMRSystem
//
//  Created by Ethan Bell on 12/1/2025.
//
//  This file contains the type Medication- a struct that holds all
//  relevant information and useful methods for a prescribed medication
//  to a patient. This type is stored in the Patient struct, which contains
//  an array consisting entirely of Medication-type objects.
//

import Foundation
import SwiftUI

// Utilising CustomStringConvertible to generate a basic description
struct Medication: CustomStringConvertible, Hashable {
    var description: String {
        return "\(name) - \(datePrescribed) - \(dosage) - \(route) - \(frequency) - \(duration) days"
    }
    // DateComponents data type used here originally to help with age calculation
    let datePrescribed: DateComponents
    let name: String
    let dosage: Dosage
    let route: routeEnum
    let frequency: String
    let duration: Int
    
    init(datePrescribed: DateComponents = DateComponents(year: 0000, month: 00, day: 00), name: String = "Unknown", dosage: Dosage, route: routeEnum = .unknown, frequency: String = "Unknown", duration: Int = 0) {
        self.datePrescribed = datePrescribed
        self.name = name
        self.dosage = dosage
        self.route = route
        self.frequency = frequency
        self.duration = duration
    }
    
    enum routeEnum: String {
        case oral = "Oral"
        case iv = "IV"
        case intramusc = "Intramuscular"
        case subcutaneous = "Subcutaneous"
        case intradermal = "Intradermal"
        case inhalation = "Inhalation"
        case sublingual = "Sublingual"
        case rectal = "Rectal"
        case topical = "Topical"
        case otic = "Otic"
        case opthalmic = "Opthalmic"
        case unknown = "Unknown"
    }
    
    // This function determines when a medication cycle has been completed
    func calculateCompleted() -> Bool {
        guard let datePrescribed = Calendar.current.date(from: datePrescribed) else {
            print("Invalid Date")
            return false
        }
        let today = Date()
        // daysBetween takes the current day compared to the current day
        let daysBetween = Calendar.current.dateComponents([.day], from: datePrescribed, to: today).day!
        // if it is larger than the duration, the medication has been completed
        if daysBetween >= duration {
            return true
        } else {
            return false
        }
    }
    
    // This function determines the day of completion
    func calculateCompletedDay() -> String {
        var dateString = ""
        guard let datePrescribed = Calendar.current.date(from: datePrescribed) else {
            return("Invalid Date")
        }
        // Line 62 was assisted by AI - byAdding (https://chatgpt.com/share/6784b414-0d24-800d-9b6d-742eee7955f7)
        let completedDate = Calendar.current.date(byAdding: .day, value: duration, to:datePrescribed) ?? Date()
        // Append it to a string- easier to return a string rather than DateComponents type
        dateString.append("\(completedDate)")
        return dateString
    }
}
