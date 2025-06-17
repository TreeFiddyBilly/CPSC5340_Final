//
//  AirportView.swift
//  Assignment3
//
//  Created by user272344 on 6/16/25.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct AirportView: View {
    @ObservedObject var airportVM = AirportViewModel()
    @Binding var isAuthenticated: Bool
    let selectedAirlineIATA: String

    @State private var searchText = ""

    var filteredAirports: [AirportModel] {
        airportVM.airports
            .filter { airport in
                searchText.isEmpty ||
                airport.airport_name.localizedCaseInsensitiveContains(searchText) ||
                airport.iata_code.localizedCaseInsensitiveContains(searchText) ||
                (airport.country_name ?? "").localizedCaseInsensitiveContains(searchText)
            }
            .sorted { $0.airport_name < $1.airport_name }
    }

    var body: some View {
        NavigationStack {
            List(filteredAirports) { airport in
                NavigationLink {
                    TimeView(
                        airportIATA: airport.iata_code,
                        airlineIATA: selectedAirlineIATA,
                        isAuthenticated: $isAuthenticated
                    )
                } label: {
                    VStack(alignment: .leading) {
                        Text(airport.airport_name)
                            .font(.headline)
                        Text(airport.country_name ?? "Unknown Country")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("IATA: \(airport.iata_code)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 4)
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onAppear {
                airportVM.fetchAirports()
            }
            .navigationTitle("Select Airport")
        }
    }
}
