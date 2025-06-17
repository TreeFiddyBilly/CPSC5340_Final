//
//  FlightTimetableModel.swift
//  Assignment3
//
//  Created by user272344 on 6/16/25.
//

import Foundation

class TimetableViewModel: ObservableObject {
    @Published private(set) var TimeData = [TimeModel]()
    @Published var errorMessage: String? = nil  // Optional: bind to UI to show errors

        private let accessKey = "d8f2ed2acf559aa905bc03bbf60ad229"

        func fetchData(airportIATA: String, flightType: String, airlineIATA: String? = nil) {
            let baseUrl = "https://api.aviationstack.com/v1/timetable"
            
            var urlComponents = URLComponents(string: baseUrl)!
            urlComponents.queryItems = [
                URLQueryItem(name: "access_key", value: accessKey),
                URLQueryItem(name: "iataCode", value: airportIATA),
                URLQueryItem(name: "type", value: flightType)
            ]
            
            guard let url = urlComponents.url else {
                print("Invalid URL")
                self.errorMessage = "Invalid URL"
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    DispatchQueue.main.async {
                        print("Fetch error: \(error.localizedDescription)")
                        self.errorMessage = "Failed to fetch data."
                    }
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        print("No data returned")
                        self.errorMessage = "No data returned from server."
                    }
                    return
                }
                
                print("URL: \(url)")
                print("Raw response: \(String(data: data, encoding: .utf8) ?? "Unable to decode")")
                
                do {
                    let results = try JSONDecoder().decode(TimetableResults.self, from: data)
                    DispatchQueue.main.async {
                        self.errorMessage = nil  // Clear any previous error
                        if let airlineFilter = airlineIATA?.uppercased() {
                            self.TimeData = results.data.filter {
                                $0.airline.iataCode?.uppercased() == airlineFilter
                            }
                        } else {
                            self.TimeData = results.data
                        }
                    }
                } catch {
                 
                    if let apiError = try? JSONDecoder().decode(APIErrorResponse.self, from: data) {
                        DispatchQueue.main.async {
                            print("API Error: \(apiError.data.error)")
                            self.TimeData = []  
                            self.errorMessage = apiError.data.error
                        }
                    } else {
                        DispatchQueue.main.async {
                            print("Decoding error: \(error.localizedDescription)")
                            self.errorMessage = "Unexpected response format."
                        }
                    }
                }
            }.resume()
        }
    }
