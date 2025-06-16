//
//  Untitled.swift
//  Assignment3
//
//  Created by user272344 on 6/16/25.
//

//

import SwiftUI
import FirebaseAuth


struct TimeDetail: View {
    let timeModel: TimeModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("✈️ Airline: \(timeModel.airline.name ?? "Unknown")")
                .font(.title2)
                .bold()
            Text("Flight: \(timeModel.flight.iataNumber ?? "N/A")")
            Text("Status: \(timeModel.status)")
            Text("Type: \(timeModel.type.capitalized)")

            Divider()

            Text("🛫 Departure")
                .font(.headline)
            Text("Time: \(timeModel.departure.scheduledTime ?? "N/A")")
            Text("Gate: \(timeModel.departure.gate ?? "-")")
            Text("Terminal: \(timeModel.departure.terminal ?? "-")")

            Divider()

            Text("🛬 Arrival")
                .font(.headline)
            Text("Time: \(timeModel.arrival.scheduledTime ?? "N/A")")
            Text("Gate: \(timeModel.arrival.gate ?? "-")")
            Text("Terminal: \(timeModel.arrival.terminal ?? "-")")

            Spacer()
        }
        .padding()
        .navigationTitle("Flight Detail")
    }
    
    func formattedTime(_ isoString: String?) -> String {
        guard
            let isoString = isoString,
            let date = ISO8601DateFormatter().date(from: isoString)
        else { return "N/A" }
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        return formatter.string(from: date)
    }
}
