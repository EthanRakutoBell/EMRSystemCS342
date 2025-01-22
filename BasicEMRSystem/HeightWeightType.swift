//
//  HeightWeightType.swift
//  BasicEMRSystem
//
//  Created by Ethan Bell on 20/1/2025.
//

import Foundation
import SwiftUI

struct HeightWeight: CustomStringConvertible, Hashable {
    
    // created custom type for height to account for unit and value
    enum UnitEnum: String {
        case cm = "cm"
        case kg = "kg"
        case ftinch = "ft/in"
        case lbs = "lbs"
        case unknown = "unknown"
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
