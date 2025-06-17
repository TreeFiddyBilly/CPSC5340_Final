//
//  AirportViewModel.swift
//  Assignment3
//
//  Created by user272344 on 6/16/25.
//

import Foundation

class AirportViewModel: ObservableObject {
    @Published var airports = [AirportModel]()
    
    private let accessKey = "d8f2ed2acf559aa905bc03bbf60ad229"
    
    func fetchAirports() {
        let urlString = "https://api.aviationstack.com/v1/airports?access_key=\(accessKey)&limit=1000"
        guard let url = URL(string: urlString) else {
            print("Invalid airports URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching airports: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data returned for airports")
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(AirportResults.self, from: data)
                DispatchQueue.main.async {
                    self.airports = decoded.data
                }
            } catch {
                print("Decoding error for airports: \(error)")
            }
        }.resume()
    }
}


