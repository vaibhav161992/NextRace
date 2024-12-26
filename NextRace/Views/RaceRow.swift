//
//  RaceRow.swift
//  NextRace
//
//  Created by Vaibhav Gajjar on 26/12/24.
//
import SwiftUI

struct RaceRow: View {
    let race: Race

    var body: some View {
        HStack {
            //View with meeting name and racing number
            VStack(alignment: .leading) {
                Text(race.meetingName)
                    .font(.headline)
                Text("Race \(race.raceNumber)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            //View with remaining time and category
            VStack {
                Text(Utilities.shared.remainingTime(for: race.advertisedStart))
                    .font(.subheadline)
                    .foregroundColor(.orange)
                Text(Utilities.shared.raceCategory(for: race.categoryId))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)

    }
}
