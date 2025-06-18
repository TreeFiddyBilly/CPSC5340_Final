//
// ContentView.swift : Assignment3
//
// Copyright © 2023 Auburn University.
// All Rights Reserved.


import SwiftUI
import FirebaseAuth

struct AirlineView: View {
    
    @ObservedObject var airlinesvm = AirlineViewModel()
    @Binding var isAuthenticated: Bool
    @State private var searchText = ""
    
    var filteredAirlines: [AirlineModel] {
        if searchText.isEmpty {
            return airlinesvm.AirlineData
        } else {
            return airlinesvm.AirlineData.filter {
                $0.airline_name?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredAirlines) { airline in
                    NavigationLink {
                        AirlineDetail(airline: airline, isAuthenticated: $isAuthenticated)
                    } label: {
                        Text(airline.airline_name ?? "")
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onAppear {
                searchText = ""
                airlinesvm.fetchData()
            }
            .listStyle(.grouped)
            .navigationTitle("Airlines")
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
            print("Error signing out \(error.localizedDescription)")
        }
    }
}
