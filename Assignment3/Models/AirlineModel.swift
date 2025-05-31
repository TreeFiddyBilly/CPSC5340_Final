//
//  AirlineModel.swift
//  Assignment3
//
//  Created by user272344 on 5/30/25.
//

import Foundation


struct Pagination: Codable {
    let offset: Int
    let limit: Int
    let count: Int
    let total: Int
}
struct AirlineResults : Codable {
    let pagination: Pagination
    let data: [AirlineModel]
}

struct AirlineModel : Codable, Identifiable {
    let id : String
    let fleet_average_age: String
    let airline_id : String
    let callsign : String
    let hub_code : String?
    let iata_code : String
    let icao_code : String
    let country_iso2 : String
    let date_founded : String?
    let airline_name : String
    let country_name : String
    let fleet_size : String
    let status : String
    let type : String?
}
