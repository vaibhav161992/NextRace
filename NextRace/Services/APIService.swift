//
//  APIService.swift
//  NextRace
//
//  Created by Vaibhav Gajjar on 26/12/24.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}

struct APIService: Networking {
    static let baseURL = "https://api.neds.com.au/rest/v1/racing/"
    
    func fetchRaces(count: Int) async throws -> [Race] {
        do {
            guard let url = URL(string: "\(APIService.baseURL)?method=nextraces&count=\(count)") else {
                throw APIError.invalidURL
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.invalidResponse
            }
            let decodedResponse = try JSONDecoder().decode(RaceResponse.self, from: data)
            return decodedResponse.data.raceSummaries.values.sorted(by: { $0.advertisedStart < $1.advertisedStart })
        } catch {
            throw APIError.decodingError
        }
    }
}

