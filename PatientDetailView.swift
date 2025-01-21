//
//  PatientDetailView.swift
//  BasicEMRSystem
//
//  Created by Ethan Bell on 19/1/2025.
//

import SwiftUI

struct PatientDetailView: View {
    @State private var showAddMedicationView: Bool = false
    @Binding var patient: Patient
    var body: some View {
        VStack() {
            // Creation of similar "profile picture" for the patient
            Text(patient.calculateInitials())
                .font(.system(size: 70) .bold())
                .foregroundColor(.black)
                .padding(20)
                .background (
                    Circle()
                        .stroke(.black, lineWidth: 2.5)
                        .frame(width: 200)
                )
            Text("\(patient.firstName) \(patient.lastName)")
                .font(.system(size: 30))
                .padding(2)
            List {
                Section("Personal Information") {
                    HStack {
                        Text("Full Name:")
                            .font(.system(size: 18) .bold())
                        Text("\(patient.firstName) \(patient.lastName)")
                    }
                    HStack {
                        Text("Date of Birth:")
                            .font(.system(size: 18) .bold())
                        // call makeDigestible to process the date in a more readable format
                        Text("\(patient.makeDigestible())")
                    }
                    HStack {
                        Text("Height:")
                            .font(.system(size: 18) .bold())
                        Text("\(patient.height)")
                    }
                    HStack {
                        Text("Weight:")
                            .font(.system(size: 18) .bold())
                        Text("\(patient.weight)")
                    }
                    HStack {
                        Text("Blood Type:")
                            .font(.system(size: 18) .bold())
                        // autofilled by xcode- but accounts for enum and optionality
                        Text("\(patient.bloodType?.typeBlood.rawValue ?? "Unknown")")
                    }
                }
                Section("Current Medications:") {
                    if patient.medications.isEmpty {
                        Text("No current medications")
                    } else {
                        // Loops through medication list and displays
                        ForEach(patient.medications, id: \.self) { medication in
                            HStack {
                                Text("\(medication.name):")
                                    .font(.system(size: 18) .bold())
                                Text("\(medication.frequency)")
                                    .underline()
                                Text("for")
                                Text("\(medication.duration) day(s)")
                                    .underline()
                            }
                        }
                    }
                }
            }
            Spacer()
            // toggle a sheet through the button
            Button(action: {self.showAddMedicationView.toggle()}) { Text("Add Medication") }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
        }
        .sheet(isPresented: $showAddMedicationView) {
            AddMedicationView(patient: $patient, showAddMedicationView: $showAddMedicationView)
        }
    }
}
