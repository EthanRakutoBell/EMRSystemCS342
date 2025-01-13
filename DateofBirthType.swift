//
//  DateofBirthType.swift
//  BasicEMRSystem
//
//  Created by Ethan Bell on 12/1/2025.
//
//  This file contains the type DOB- a struct that holds the
//  calculated date of birth of a given patient. It also contains
//  the method calculateAge(), which uses Calendar() and date()
//  functions to calculate a given patient's age.
//

import Foundation
import SwiftUI

struct DOB: CustomStringConvertible {
    var description: String {"Date of Birth: \(DOB)"}
    var DOB: DateComponents
    
    init(DOB: DateComponents = DateComponents(year: 0000, month: 00, day: 00)) {
        self.DOB = DOB
    }
    
    // This function calculates the age of the patient. Some of the code
    // was assisted by Generative AI (https://chatgpt.com/share/6784b78b-4cbc-800d-89cb-5369a2f0b59a), and
    // this website (https://www.hackingwithswift.com/books/ios-swiftui/working-with-dates)
    // I used to better understand (and originally discover) the DateComponents type. This
    // is where a majority of understanding of DateComponents was gained, which served as
    // some foundational knowledge for other tasks in this assignment.
    func calculateAge() -> Int {
        guard let birthDate = Calendar.current.date(from: DOB) else {
            print("Invalid Birthdate.")
            return 0
        }
        let today = Date()
        // takes in the year difference between the birthdate and todays date,
        // which allows for age calculation.
        let ageDate = Calendar.current.dateComponents([.year], from: birthDate, to: today)
        return ageDate.year ?? 0
    }
}
