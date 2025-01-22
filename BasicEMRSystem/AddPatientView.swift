//
//  AddPatientView.swift
//  BasicEMRSystem
//
//  Created by Ethan Bell on 19/1/2025.
//

import SwiftUI

struct AddPatientView: View {
    @Bindable var patientList = PatientList()
    // dismiss pops a view from the navigation stack, allows for easy return
    @Environment(\.dismiss) private var dismiss
    
    // all these variables stored locally- in @state, don't need them to be seen in other views
    @State var patientFirstName: String = ""
    @State var patientLastName: String = ""
    @State var patientDOB: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    @State var patientHeightInt = 0.0
    @State var patientHeightUnit: HeightWeight.UnitEnum = .cm
    @State var patientWeightInt = 0.0
    @State var patientWeightUnit: HeightWeight.UnitEnum = .kg
    @State var patientBloodType = BloodType()
    @State private var displayMessage: Bool = false
    @State private var errorMessage: String = ""
    
    // height and weight need a unit and a value, so create two separate values and combine into one
    private var patientHeight: HeightWeight {
        return HeightWeight(value: patientHeightInt, unit: patientHeightUnit)
    }
    private var patientWeight: HeightWeight {
        return HeightWeight(value: patientWeightInt, unit: patientWeightUnit)
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("First Name")
                    .font(.system(size: 15))) {
                        TextField(
                            "First Name",
                            text: $patientFirstName
                        )
                    }
                Section(header: Text("Last Name")
                    .font(.system(size: 15))) {
                        TextField(
                            "Last Name",
                            text: $patientLastName
                        )
                    }
                Section(header: Text("Date of Birth")
                    .font(.system(size: 15))) {
                        HStack {
                            // Used datepicker here- set the new date and default date is todays date
                            DatePicker("Date of Birth", selection: Binding (
                                get: {
                                    Calendar.current.date(from: patientDOB) ?? Date()
                                }, set: { newDate in patientDOB = Calendar.current.dateComponents([.year, .month, .day], from: newDate)
                                }), displayedComponents: .date
                            )
                            .accessibilityIdentifier("DateOfBirthPicker")
                        }
                    }
                // Double selection- value (double) and unit (picker)
                Section(header: Text("Height")
                    .font(.system(size: 15))) {
                        HStack {
                            TextField(
                                value: $patientHeightInt,
                                format: .number
                            ) {
                                Text("Amount (Height)")
                            }
                            .accessibilityIdentifier("HeightAmount")
                            Picker("Unit", selection: $patientHeightUnit) {
                                Text("cm").tag(HeightWeight.UnitEnum.cm)
                                Text("ft/in").tag(HeightWeight.UnitEnum.ftinch)
                                }
                            .pickerStyle(DefaultPickerStyle())
                            .accessibilityIdentifier("HeightUnitPicker")
                        }
                    }
                Section(header: Text("Weight")
                    .font(.system(size: 15))) {
                        HStack {
                            TextField(
                                value: $patientWeightInt,
                                format: .number
                            ) {
                                Text("Amount (Weight)")
                            }
                            .accessibilityIdentifier("WeightAmount")
                            Picker("Unit", selection: $patientWeightUnit) {
                                Text("kg").tag(HeightWeight.UnitEnum.kg)
                                Text("lbs").tag(HeightWeight.UnitEnum.lbs)
                                }
                            .pickerStyle(DefaultPickerStyle())
                            .accessibilityIdentifier("WeightPicker")
                        }
                    }
                Section(header: Text("Blood Type")
                    .font(.system(size: 15))) {
                        Picker("Blood Type", selection: $patientBloodType.typeBlood) {
                            Text("A+").tag(BloodType.typeBloodEnum.APlus)
                            Text("A-").tag(BloodType.typeBloodEnum.AMinus)
                            Text("B+").tag(BloodType.typeBloodEnum.BPlus)
                            Text("B-").tag(BloodType.typeBloodEnum.BMinus)
                            Text("O-").tag(BloodType.typeBloodEnum.OMinus)
                            Text("O+").tag(BloodType.typeBloodEnum.OPlus)
                            Text("AB-").tag(BloodType.typeBloodEnum.ABMinus)
                            Text("AB+").tag(BloodType.typeBloodEnum.ABPlus)
                            Text("Unknown").tag(BloodType.typeBloodEnum.unknown)
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
            }
            NavigationLink(
                destination: {
                    PatientListView()
                },
                label: {
                    // button's action is to call checkInput()
                    Button(action: {
                        // if checkInput() passes- then create the patient
                        if checkInput() {
                            let newPatient =  Patient(firstName: patientFirstName, lastName: patientLastName, dateOfBirth: patientDOB, height: patientHeight, weight: patientWeight, bloodType: patientBloodType)
                            // append to both patients and filtered patients- solution to a bug in which either one of the lists was not being updated and so new patients weren't being displayed
                            patientList.patients.append(newPatient)
                            patientList.filteredPatients.append(newPatient)
                            // sort new patients by last name here
                            patientList.patients.sort { $0.lastName < $1.lastName }
                            patientList.filteredPatients.sort { $0.lastName < $1.lastName }
                            // need for a bool from documentation- display success message
                            displayMessage = true
                            errorMessage = "\(patientFirstName) added successfully"
                            dismiss()
                        }
                    }) { Text("Save Patient") }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        // when the button is clicked, the alert will be presented- whether error or success
                        .alert(isPresented: $displayMessage) {
                            Alert(title: Text("\(errorMessage)"))
                        }
                }
            )
        }
    }
    
    // this function checks for empty fields that need to be filled out
    private func checkInput() -> Bool {
        if patientFirstName.isEmpty || patientLastName.isEmpty || patientHeightInt == 0.0 || patientWeightInt == 0.0 || DOBEmpty() {
            displayMessage = true
            // modifies the error message so that this will be sent when button is clicked
            errorMessage = "Missing Information"
            return false
        }
        return true
    }
    
    private func DOBEmpty() -> Bool {
        return patientDOB.year == nil || patientDOB.month == nil || patientDOB.day == nil
    }
}
