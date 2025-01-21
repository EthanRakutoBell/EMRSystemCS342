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
    var typeBlood: typeBloodEnum
    var description: String {
        "Blood Type: \(typeBlood)"
    }
    
    // recreated bloodtype struct to include enum
    enum typeBloodEnum: String {
        case APlus = "A+"
        case AMinus = "A-"
        case BPlus = "B+"
        case BMinus = "B-"
        case OPlus = "O+"
        case OMinus = "O-"
        case ABPlus = "AB+"
        case ABMinus = "AB-"
        case unknown = "Unknown"
    }
    
    init(typeBlood: typeBloodEnum = .unknown) {
        self.typeBlood = typeBlood
    }
}
