//
//  TimeView.swift
//  Assignment3
//
//  Created by user272344 on 6/16/25.
//

import SwiftUI
import FirebaseAuth

struct TimeView: View {
    @ObservedObject var timetableVM = TimetableViewModel()
    let airportIATA: String
    let airlineIATA: String
    @Binding var isAuthenticated: Bool

    var body: some View {
        NavigationStack {
            List {
                ForEach(timetableVM.TimeData) { timeModel in
                    NavigationLink {
                        TimeDetail(timeModel: timeModel)
                    } label: {
                        Text(timeModel.flight.iataNumber ?? "Unknown Flight")
                    }
                }
            }
            .onAppear {
                timetableVM.fetchData(airportIATA: airportIATA, flightType: "departure", airlineIATA: airlineIATA)
            }
            .navigationTitle("Timetable")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Sign Out") {
                        signOut()
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            isAuthenticated = false
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

