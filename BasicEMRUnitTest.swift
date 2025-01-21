//
//  BasicEMRUnitTest.swift
//  BasicEMRUnitTest
//
//  Created by Ethan Bell on 12/1/2025.
//  This file contains the given unit tests with three Patient instances
//  to test various functionality and methods of the database.

import Testing
@testable import BasicEMRSystem
import Foundation

struct BasicEMRSystemTests {

    // This patient instance tests basic information, blood type information,
    // compatible blood types, empty medications edge case, and general
    // CustomStringConvertible functionality.
    /*@Test func testBasicInfo() async throws {
        let TestPatient = Patient(firstName: "Totoro", lastName: "My Neighbor", dateOfBirth: DateComponents(year: 1935, month: 9, day: 5)), height: HeightWeight(value: 180, unit: HeightWeight.UnitEnum.cm), weight: HeightWeight(value: 70, unit: HeightWeight.UnitEnum.kg), bloodType: BloodType(typeBlood: BloodType.typeBloodEnum(rawValue: "O+") ?? .OPlus), medications: [])
        
        #expect(TestPatient.basicInfo() == "My Neighbor, Totoro, (89 years)")
        #expect(TestPatient.bloodTypeInfo() == "Totoro My Neighbor's blood type is: O+")
        #expect(TestPatient.compatibleBloodType() == ["O-", "O+"])
        #expect(TestPatient.medicationInfo() == ["No medications"])
        print(BloodType)
        print(BirthDate)
    }
    
    // This patient instance tests medication information, notably whether the
    // medicationInfo() function will sort and only display incomplete medications.
    // This also tests completed medication methods, incorrect blood type response,
    // and other CustomStringConvertible functionality.
    @Test func testMedicationInfo() async throws {
        let BirthDate = DOB(DOB: DateComponents(year: 1998, month: 5, day: 8))
        let BloodType = BloodType(typeBlood: "C+")
        let Medication1 = Medication(datePrescribed: DateComponents(year: 2024, month: 12, day: 18), name: "Tylenol", dosage: "20mg", route: "Mouth", frequency: "Once a day", duration: 50)
        let Medication2 = Medication(datePrescribed: DateComponents(year: 2025, month: 1, day: 10), name: "Kakkonto", dosage: "15mg", route: "Mouth", frequency: "Once a day", duration: 12)
        let Medication3 = Medication(datePrescribed: DateComponents(year: 2025, month: 1, day: 1), name: "Aspirin", dosage: "5mg", route: "Mouth", frequency: "Once a day", duration: 20)
        let Medication4 = Medication(datePrescribed: DateComponents(year: 2023, month: 2, day: 18), name: "Sakura", dosage: "35mg", route: "Eyes", frequency: "Once a day", duration: 100)
        let Medication5 = Medication(datePrescribed: DateComponents(year: 2021, month: 6, day: 29), name: "Custard Apple", dosage: "1mg", route: "Mouth", frequency: "Twice a day", duration: 25)
        let TestPatient = Patient(firstName: "Ponyo", lastName: "Fishy in the Sea", DOB: BirthDate, height: 30, weight: 23, bloodType: BloodType, medications: [Medication2, Medication1, Medication3, Medication4, Medication5])
        
        #expect(TestPatient.medicationInfo() == ["Tylenol (Prescribed on year: 2024 month: 12 day: 18 )", "Aspirin (Prescribed on year: 2025 month: 1 day: 1 )", "Kakkonto (Prescribed on year: 2025 month: 1 day: 10 )"])
        #expect(TestPatient.completedMedication() == ["Sakura, Completed on 2023-05-29 07:00:00 +0000", "Custard Apple, Completed on 2021-07-24 07:00:00 +0000"])
        print(TestPatient)
        print(Medication2)
        #expect(TestPatient.bloodTypeInfo() == "Ponyo Fishy in the Sea's blood type is: Invalid")
    }
    
    // This patient instance tests for prescribing medication to a patient and
    // error testing for prescribing a duplicate medication. It also tests
    // the allInfo() function.
    @Test func testPrescribeMedication() async throws {
        let BirthDate = DOB(DOB: DateComponents(year: 2003, month: 2, day: 21))
        let BloodType = BloodType(typeBlood: "A-")
        let Medication1 = Medication(datePrescribed: DateComponents(year: 2024, month: 12, day: 18), name: "Tylenol", dosage: "20mg", route: "Mouth", frequency: "Once a day", duration: 50)
        let Medication2 = Medication(datePrescribed: DateComponents(year: 2025, month: 1, day: 10), name: "Kakkonto", dosage: "15mg", route: "Mouth", frequency: "Once a day", duration: 12)
        let Medication3 = Medication(datePrescribed: DateComponents(year: 2025, month: 1, day: 1), name: "Aspirin", dosage: "5mg", route: "Mouth", frequency: "Once a day", duration: 20)
        let Medication4 = Medication(datePrescribed: DateComponents(year: 2025, month: 1, day: 2), name: "Gum-Gum Fruit", dosage: "1mg", route: "Mouth", frequency: "Once", duration: 20)
        let Medication5 = Medication(datePrescribed: DateComponents(year: 2025, month: 1, day: 5), name: "Aspirin", dosage: "5mg", route: "Mouth", frequency: "Once a day", duration: 20)
        var TestPatient = Patient(firstName: "Luffy", lastName: "Monkey D", DOB: BirthDate, height: 190, weight: 70, bloodType: BloodType, medications: [Medication2, Medication1, Medication3])
        
        // Prescribes new medication, checks if medication is added to the array,
        // prescribes duplicate medication, checks if error is thrown.
        try TestPatient.prescribeMedication(med: Medication4)
        #expect (TestPatient.medicationInfo() == ["Tylenol (Prescribed on year: 2024 month: 12 day: 18 )", "Aspirin (Prescribed on year: 2025 month: 1 day: 1 )", "Gum-Gum Fruit (Prescribed on year: 2025 month: 1 day: 2 )", "Kakkonto (Prescribed on year: 2025 month: 1 day: 10 )"])
        withKnownIssue {
            try TestPatient.prescribeMedication(med: Medication5)
        }
        
        
        #expect (TestPatient.allInfo() == "Monkey D, Luffy, (21 years), 190 cm, 70 kg, Blood type: A-")
    }
*/
}

