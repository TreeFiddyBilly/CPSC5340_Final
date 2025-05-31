//
// ContentView.swift : Assignment3
//
// Copyright © 2023 Auburn University.
// All Rights Reserved.


import SwiftUI

struct AirlineView: View {
    
    @ObservedObject var airlinesvm = AirlineViewModel()
    
    
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AirlineView()
    }
}
