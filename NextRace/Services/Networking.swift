//
//  Networking.swift
//  NextRace
//
//  Created by Vaibhav Gajjar on 26/12/24.
//
protocol Networking {
    func fetchRaces(count: Int) async throws -> [Race]
}
