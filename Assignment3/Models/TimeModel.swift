//
//  TimeModel.swift
//  Assignment3
//
//  Created by user272344 on 6/16/25.
//

import Foundation

struct TimetableResults: Codable {
    let data: [TimeModel]
    let pagination: Pagination
}

struct TimeModel: Codable, Identifiable {

    var id: String { flight.iataNumber ?? UUID().uuidString } 
    
    let airline: Airline
    let arrival: FlightInfo
    let departure: FlightInfo
    let codeshared: CodeShared?
    let flight: Flight
    let status: String
    let type: String
}

struct Airline: Codable {
    let iataCode: String?
    let icaoCode: String?
    let name: String?
}

struct FlightInfo: Codable {
    let actualRunway: String?
    let actualTime: String?
    let baggage: String?
    let delay: String?
    let estimatedRunway: String?
    let estimatedTime: String?
    let gate: String?
    let iataCode: String?
    let icaoCode: String?
    let scheduledTime: String?
    let terminal: String?
}

struct CodeShared: Codable {
    let airline: Airline
    let flight: Flight
}

struct Flight: Codable {
    let iataNumber: String?
    let icaoNumber: String?
    let number: String?
}

struct APIErrorResponse: Codable {
    let data: APIErrorData
}

struct APIErrorData: Codable {
    let error: String
    let success: Bool
}
