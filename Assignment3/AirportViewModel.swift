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
    
    func fetchAirports(for airlineIATA: String) {
            let apiKey = "d8f2ed2acf559aa905bc03bbf60ad229"
            let urlString = "https://api.aviationstack.com/v1/airports?limit=1000&access_key=\(apiKey)&airline_iata=\(airlineIATA)"
            
            guard let url = URL(string: urlString) else {
                print("Invalid airport URL")
                return
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Airport fetch error: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    print("No data returned for airport fetch.")
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(AirportResults.self, from: data)
                    DispatchQueue.main.async {
                        self.airports = decoded.data
                    }
                } catch {
                    print("Airport decoding error: \(error)")
                }
            }.resume()
        }
    }
