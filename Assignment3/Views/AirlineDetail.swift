//
//  AirlineDetail.swift
//  Assignment3
//
//  Created by user272344 on 5/30/25.
//

import SwiftUI

struct AirlineDetail: View {

    var airline : AirlineModel
    @Binding var isAuthenticated: Bool
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(airline.airline_name)
                Text("Airline ID: ") + Text(airline.airline_id)
                Text("Average Fleet Age: ") + Text(airline.fleet_average_age)
                Text("Call Sign: ") + Text(airline.callsign)
                Text("Hub Code: ") + Text(airline.hub_code ?? "N/A")
                Text("Country: ") + Text(airline.country_name)
                Text("Date Founded: ") + Text(airline.date_founded ?? "N/A")
                Text("Fleet Size: ") + Text(airline.fleet_size)
                Text("Status: ") + Text(airline.status)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            Spacer()
            NavigationLink {
                AirportView(isAuthenticated: $isAuthenticated, selectedAirlineIATA: airline.iata_code)
                      } label: {
                          Text("View Airports")
                              .foregroundColor(.white)
                              .padding()
                              .frame(maxWidth: .infinity)
                              .background(Color.blue)
                              .cornerRadius(8)
                              .padding(.horizontal)
                      }        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}


