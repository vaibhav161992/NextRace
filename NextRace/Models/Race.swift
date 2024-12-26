//
//  Race.swift
//  NextRace
//
//  Created by Vaibhav Gajjar on 26/12/24.
//
import Foundation

struct RaceResponse: Codable {
    let data: RaceData
}

struct RaceData: Codable {
    enum CodingKeys: String, CodingKey {
        case raceSummaries = "race_summaries"
    }
    
    let raceSummaries: [String: Race]
}

struct Race: Codable, Identifiable {
    
    enum CodingKeys: String, CodingKey {
        case id = "race_id"
        case meetingName = "meeting_name"
        case raceNumber = "race_number"
        case advertisedStart = "advertised_start"
        case categoryId = "category_id"
        case seconds
    }
    
    let id: String
    let meetingName: String
    let raceNumber: Int
    let advertisedStart: Date
    let categoryId: String
    let seconds: Double
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        meetingName = try container.decode(String.self, forKey: .meetingName)
        raceNumber = try container.decode(Int.self, forKey: .raceNumber)
        categoryId = try container.decode(String.self, forKey: .categoryId)
        let secondContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .advertisedStart)
        seconds = try secondContainer.decode(Double.self, forKey: .seconds)
        advertisedStart = Date(timeIntervalSince1970: seconds)
    }
    
    init (id: String, meetingName: String, raceNumber: Int, advertisedStart: Date, categoryId: String) {
        self.id = id
        self.meetingName = meetingName
        self.raceNumber = raceNumber
        self.advertisedStart = advertisedStart
        self.categoryId = categoryId
        self.seconds = 0
    }
}
