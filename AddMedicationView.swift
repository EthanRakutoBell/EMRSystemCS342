//
//  AddMedicationView.swift
//  BasicEMRSystem
//
//  Created by Ethan Bell on 19/1/2025.
//

import SwiftUI

struct AddMedicationView: View {
    @Binding var patient: Patient
    @Binding var showAddMedicationView: Bool
    @State private var medicationName: String = ""
    @State private var medicationDosageInt: Double = 0.0
    @State private var medicationDosageUnit: Dosage.UnitEnum = .unknown
    @State private var medicationRoute: Medication.routeEnum = .unknown
    @State private var medicationFrequency: String = ""
    @State private var medicationDuration: Int = 0
    @State private var displayMessage: Bool = false
    @State private var errorMessage: String = ""
    
    // similar argument to addPatientView - dosage requires two inputs, so combine into one variable here
    private var medicationDosage: Dosage {
        return Dosage(value: medicationDosageInt, unit: medicationDosageUnit)
    }
    
    var body: some View {
        VStack {
            HStack {
                // toggle the sheet with a physical back button- not a navigationLink
                Button(action: {self.showAddMedicationView.toggle()}) {
                    label: do {
                    Label("Back", systemImage: "chevron.backward")}
                }
                .font(.system(size: 20))
                .padding(20)
                Spacer()
            }
            List {
                Section(header: Text("Medication Name")
                    .font(.system(size: 15))) {
                    TextField(
                        "Required",
                        text: $medicationName
                    )
                }
                Section(header: Text("Dosage")
                    .font(.system(size: 15))) {
                    HStack {
                        TextField(
                            value: $medicationDosageInt,
                            format: .number
                        ) {
                            Text("Amount")
                        }
                        Picker("", selection: $medicationDosageUnit) {
                            Text("mg").tag(Dosage.UnitEnum.mg)
                            Text("mL").tag(Dosage.UnitEnum.ml)
                            Text("g").tag(Dosage.UnitEnum.g)
                            Text("L").tag(Dosage.UnitEnum.l)
                            Text("mcg").tag(Dosage.UnitEnum.mcg)
                            Text("Unknown").tag(Dosage.UnitEnum.unknown)
                            }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                Section(header: Text("Route")
                        // was suggested to make route an enum, a picker used to display possible routes for medication
                    .font(.system(size: 15))) {
                        Picker("", selection: $medicationRoute) {
                            Text("Oral").tag(Medication.routeEnum.oral)
                            Text("IV").tag(Medication.routeEnum.iv)
                            Text("Intramuscular").tag(Medication.routeEnum.intramusc)
                            Text("Subcutaneous").tag(Medication.routeEnum.subcutaneous)
                            Text("Intradermal").tag(Medication.routeEnum.intradermal)
                            Text("Inhalation").tag(Medication.routeEnum.inhalation)
                            Text("Sublingual").tag(Medication.routeEnum.sublingual)
                            Text("Rectal").tag(Medication.routeEnum.rectal)
                            Text("Topical").tag(Medication.routeEnum.topical)
                            Text("Otic").tag(Medication.routeEnum.otic)
                            Text("Opthalmic").tag(Medication.routeEnum.opthalmic)
                            Text("Unknown").tag(Medication.routeEnum.unknown)
                            }
                        .pickerStyle(MenuPickerStyle())
                    }
                // decided to not make frequency an enum- as variations are much more wide (2x a week, 5x a week, biweekly, etc.)
                Section(header: Text("Frequency")
                    .font(.system(size: 15))) {
                        TextField(
                            "Required",
                            text: $medicationFrequency
                        )
                    }
                Section(header: Text("Duration")
                    .font(.system(size: 15))) {
                        HStack() {
                            TextField(
                                value: $medicationDuration,
                                format: .number
                            ) {
                            }
                            Text("Days")
                        }
                    }
            }
            Button(action: {
                // created this variable for the throw, as prescribeMedication() always returns a string
                var resultMessage = ""
                // similar to addPatient- if button is clicked create a new medication variable
                if checkInput() {
                    let newMedication =  Medication(datePrescribed: Calendar.current.dateComponents([.year, .month, .day], from: Date()), name: medicationName, dosage: medicationDosage, route: Medication.routeEnum(rawValue: medicationRoute.rawValue) ?? .unknown, frequency: medicationFrequency, duration: medicationDuration)
                    do {
                        // resultMessage will either be an error or success, which will be displayed
                        try resultMessage = patient.prescribeMedication(med: newMedication)
                        displayMessage = true
                        errorMessage = resultMessage
                        self.showAddMedicationView.toggle()
                    } catch {
                        displayMessage = true
                        errorMessage = "Unable to Prescribe Medication"
                    }
            }
            }) { Text("Save Medication") }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.green)
                .cornerRadius(10)
                .alert(isPresented: $displayMessage) {
                    Alert(title: Text("\(errorMessage)"))
                }
        }
    }
    
    // Also created a checkInput() function that checks for missing information and duplicates
    private func checkInput() -> Bool {
        if medicationName.isEmpty || medicationRoute == .unknown || medicationDuration == 0 || medicationDosageInt == 0 || medicationFrequency.isEmpty {
            displayMessage = true
            errorMessage = "Missing Information"
            return false
        }
        if patient.medications.contains(where: { $0.name == medicationName }) {
            displayMessage = true
            errorMessage = "Medication already prescribed"
            return false
        }
        return true
    }
}
