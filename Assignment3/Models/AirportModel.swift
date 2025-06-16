//
//  AirportModel.swift
//  Assignment3
//
//  Created by user272344 on 6/16/25.
//

import Foundation

struct AirportResults: Codable {
    let pagination: Pagination
    let data: [AirportModel]
}

struct AirportModel: Codable, Identifiable {

    var id: String { iata_code }
    
    let id_api: String      
    let gmt: String?
    let airport_id: String
    let iata_code: String
    let city_iata_code: String
    let icao_code: String
    let country_iso2: String
    let airport_name: String
    let country_name: String?
    let timezone: String?
    
    enum CodingKeys: String, CodingKey {
        case id_api = "id"
        case gmt, airport_id, iata_code, city_iata_code, icao_code, country_iso2, airport_name, country_name, timezone
    }
}
