//
//  DosageType.swift
//  BasicEMRSystem
//
//  Created by Ethan Bell on 19/1/2025.
//

import Foundation
import SwiftUI

struct Dosage: CustomStringConvertible, Hashable {
    
    // constructed dosage type to account for unit and value
    enum UnitEnum: String {
        case mg = "mg"
        case ml = "mL"
        case g = "g"
        case l = "L"
        case mcg = "mcg"
        case unknown = "Unknown"
    }
    
    var description: String {
        return ("\(value) \(unit)")
    }
    
    let value: Double
    let unit: UnitEnum
    
    init(value: Double = 0.0, unit: UnitEnum = .unknown) {
        self.value = value
        self.unit = unit
    }
}
