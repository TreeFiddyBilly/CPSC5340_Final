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
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(airlinesvm.AirlineData) {airline in
                    NavigationLink{
                        AirlineDetail(airline: airline)
                    } label: {
                        Text(airline.airline_name)
                    }                }
                
            }
                .onAppear {
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


