//
//  BloodType.swift
//  BasicEMRSystem
//
//  Created by Ethan Bell on 12/1/2025.
//  This file contains the type BloodType- a struct that holds the
//  blood type of a given patient. This is stored in the patient struct under
//  "bloodType". 
//


import Foundation
import SwiftUI

struct BloodType: CustomStringConvertible, Hashable {
    var description: String { "Blood Type: \(typeBlood)" }
    var typeBlood: String
    
    init(typeBlood: String = "Unknown") {
        // Only sets blood type if it is on the list of valid blood types
        if typeBlood == "A+"||typeBlood == "B+"||typeBlood == "O+"||typeBlood == "AB+" || typeBlood == "A-"||typeBlood == "B-"||typeBlood == "O-"||typeBlood == "AB-" {
            self.typeBlood = typeBlood
        // otherwise sets as "invalid"
        } else {
            print("Invalid Blood Type")
            self.typeBlood = "Invalid"
        }
    }
}
