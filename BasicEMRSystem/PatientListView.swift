//
//  PatientListView.swift
//  BasicEMRSystem
//
//  Created by Ethan Bell on 19/1/2025.
//

import SwiftUI

// Dummy patient and medication
let Medication1 = Medication(datePrescribed: DateComponents(year: 2024, month: 12, day: 18), name: "Gum-Gum Fruit", dosage: Dosage(value: 5, unit: Dosage.UnitEnum.mg), route: Medication.routeEnum.oral, frequency: "Once", duration: 1)

//@Observable
// edit: upon building the application, the dynamic functionality only worked in preview mode.
// Thus, to fix this problem, reverted back to old usage of ObservableObject class and @Published
// as this appeared to work upon launching the app
class PatientList: ObservableObject {
    @Published var patients: [Patient] = [
        Patient(firstName: "Luffy", lastName: "Monkey D", dateOfBirth: DateComponents(year: 1999, month: 11, day: 8), height: HeightWeight(value: 180, unit: HeightWeight.UnitEnum.cm), weight: HeightWeight(value: 70, unit: HeightWeight.UnitEnum.kg), bloodType: BloodType(typeBlood: BloodType.typeBloodEnum(rawValue: "O+") ?? .OPlus), medications: [Medication1])
    ]
    // Separate patient list for the search query
    // edit: used @Published
    @Published var filteredPatients: [Patient] = []
    
    // Since all edits are being made to the filtered list, this updates the original patient list
    func fixPatientList() {
        for filteredPatient in filteredPatients {
            // finds the id of the matching patient and replaces with edited patient
            if let index = patients.firstIndex(where: { $0.id == filteredPatient.id}) {
                patients[index] = filteredPatient
            }
        }
    }
    
    // initialise the search list as the full list for the first launch
    init() {
        self.filteredPatients = self.patients
    }
}

struct PatientListView: View {
    // Used ObservedObject over @Bindable here- simply had to test the old method as @Bindable
    // did not appear to update patientList within the app launch and only within preview
    @ObservedObject var patientList = PatientList()
    @State private var searchText = ""
    var body: some View {
            NavigationStack {
                List {
                    ForEach($patientList.filteredPatients) { patient in
                        NavigationLink(
                            destination: {
                                PatientDetailView(patient: patient)
                            },
                            label: {
                                PatientRowView(patient: patient)
                            }
                        )
                    }
                }
                .navigationTitle("All Patients")
                .searchable(text: $searchText)
                // when query is created, call searchResults
                .onChange(of: searchText) { newValue in
                    searchResults(searchText: newValue)
                }
                Spacer()
                NavigationLink(
                    destination: {
                        AddPatientView(patientList: patientList)
                    },
                    label: {
                        Text("Add Patient")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                )
            }
        }
    
    // This function creates the search query
    func searchResults(searchText: String) {
        if searchText.isEmpty {
            // first updates the patient list
            patientList.fixPatientList()
            // if empty- set to the full patient list
            patientList.filteredPatients = patientList.patients
        } else {
            patientList.fixPatientList()
            // if not empty, filter the search by last name
            patientList.filteredPatients = patientList.patients.filter { patient in
                patient.lastName.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
