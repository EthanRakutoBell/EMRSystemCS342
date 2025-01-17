//
//  ContentView.swift
//  BasicEMRSystem
//
//  Created by Ethan Bell on 12/1/2025.
//

import SwiftUI

let Medication1 = Medication(datePrescribed: DateComponents(year: 2024, month: 12, day: 18), name: "Gum-Gum Fruit", dosage: "5g", route: "Mouth", frequency: "Once", duration: 1)

@Observable
class PatientList {
    private(set) var patients: [Patient] = [
        Patient(firstName: "Luffy", lastName: "Monkey D", DOB: DOB(DOB: DateComponents(year: 1999, month: 11, day: 8)), height: 200, weight: 75, bloodType: BloodType(typeBlood: "O+"), medications: [Medication1])
    ]
}

struct PatientListView: View {
    @State private var patientList = PatientList()
    var body: some View {
        NavigationStack {
            List(patientList.patients) { patient in
                NavigationLink(value: patient) {
                    HStack {
                        Text(patient.calculateInitials())
                            .font(.system(size: 30) .bold())
                            .foregroundColor(.black)
                            .padding(12)
                            .background (
                                Circle()
                                    .stroke(   .black, lineWidth: 2.5)
                                    .frame(width: 100)
                            )
                        Spacer().frame(width: 20)
                        VStack(alignment: .leading) {
                            Text("\(patient.firstName) \(patient.lastName)")
                                .font(.headline)
                            Text("\(patient.DOB.calculateAge()) years")
                                .font(.subheadline)
                            Text("MRN: \(String(patient.MRN))")
                                .font(.caption)
                        }
                    }
                }
            }
            .navigationTitle("All Patients")
            .navigationDestination(for: Patient.self) { patient in PatientDetailView(patient: patient)
            }
        }
    }
}

struct PatientDetailView: View {
    var patient: Patient
    var body: some View {
        VStack() {
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
            Text("MRN: \(String(patient.MRN))")
                .font(.system(size: 15))
            List() {
                Section("Personal Information") {
                    HStack {
                        Text("Full Name:")
                            .font(.system(size: 18) .bold())
                        Text("\(patient.firstName) \(patient.lastName)")
                    }
                    HStack {
                        Text("Date of Birth:")
                            .font(.system(size: 18) .bold())
                        Text("\(patient.DOB.makeDigestible()) (\(patient.DOB.calculateAge()) years)")
                    }
                    HStack {
                        Text("Height:")
                            .font(.system(size: 18) .bold())
                        Text("\(patient.height) cm")
                    }
                    HStack {
                        Text("Weight:")
                            .font(.system(size: 18) .bold())
                        Text("\(patient.weight) kg")
                    }
                    HStack {
                        Text("Blood Type:")
                            .font(.system(size: 18) .bold())
                        Text("\(patient.bloodType.typeBlood)")
                    }
                }
                Section("Current Medications:") {
                    if patient.medications.isEmpty {
                        Text("No current medications")
                    } else {
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
            NavigationLink(value: patient) {
                Text("Add Medication")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .navigationTitle("Add Medication")
        .navigationDestination(for: Patient.self) { patient in AddMedicationView(patient: patient)
        }
    }
}
    
struct AddMedicationView: View {
    var patient: Patient
    var body: some View {
        Text("Hi")
    }
}
    
#Preview {
    PatientListView()
}
