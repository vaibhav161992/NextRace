//
//  MockAPIService.swift
//  NextRace
//
//  Created by Vaibhav Gajjar on 26/12/24.
//
import Foundation
@testable import NextRace

class MockAPIService: Networking {
    var isServiceCalled: Bool = false
     func fetchRaces(count: Int) async throws -> [Race] {
         isServiceCalled = true
        return [
            Race(id: "1", meetingName: "Mock Melbourne", raceNumber: 1, advertisedStart: Date().addingTimeInterval(300), categoryId: AppConstants.horseCatrgoryID),
            Race(id: "2", meetingName: "Mock Sydney", raceNumber: 2, advertisedStart: Date().addingTimeInterval(-120), categoryId: AppConstants.harnessCatrgoryID)
        ]
    }
}
