//
//  Utilities.swift
//  NextRace
//
//  Created by Vaibhav Gajjar on 26/12/24.
//
import Foundation

final class Utilities {
    
    static let shared = Utilities()
    
    func remainingTime(for startTime: Date) -> String {
        let interval = Int(startTime.timeIntervalSinceNow)
        let minumtesString = ((interval / 60) > 0) ? "\(interval / 60)m" : ""
        return interval > 0 ? "\(minumtesString) \(interval % 60)s" : "Closed"
    }
    
    func raceCategory(for id: String) -> String {
        switch id {
        case AppConstants.horseCatrgoryID: return "Horse"
        case AppConstants.harnessCatrgoryID: return "Harness"
        case AppConstants.greyHoundCatrgoryID: return "Greyhound"
        default: return "Unknown"
        }
    }
}

extension Date {
    // To check whether date is withing minute
    func isWithinLastMinute() -> Bool {
        return self > Date().addingTimeInterval(-60)
    }
}
