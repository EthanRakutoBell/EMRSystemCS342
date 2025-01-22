//
//  PatientRowView.swift
//  BasicEMRSystem
//
//  Created by Ethan Bell on 20/1/2025.
//

import SwiftUI

// Created to break up PatientListView for the compiler
struct PatientRowView: View {
    let patient: Binding<Patient>
    
    var body: some View {
        HStack {
            // This creates an aesthetically pleasing "profile picture" for the patient
            Text(patient.wrappedValue.calculateInitials())
                .font(.system(size: 30) .bold())
                .foregroundColor(.black)
                .padding(12)
                .background (
                    Circle()
                        .stroke(.black, lineWidth: 2.5)
                        .frame(width: 100)
                )
            // using wrappedValue since the patient variable is Binding<patient>
            Spacer().frame(width: 20)
            VStack(alignment: .leading) {
                Text("\(patient.wrappedValue.firstName) \(patient.wrappedValue.lastName)")
                    .font(.headline)
                
                Text("\(ageResult(for: patient.wrappedValue))")
                    .font(.subheadline)
                
                Text("MRN: \(patient.MRN.wrappedValue)")
                    .font(.system(size: 8))
            }
        }
    }
    // separated into a function for age result to manage the throw
    private func ageResult(for patient: Patient) -> String {
        do {
            let age = try patient.calculateAge()
             return "\(age) years"
        } catch dateofBirthError.FutureDate {
            return "Invalid Birthdate: future date"
        } catch dateofBirthError.Invalid {
            return "Invalid Birthdate"
        } catch {
            return "Unknown Error"
        }
    }
}
