//
//  RacingListViewModel.swift
//  NextRace
//
//  Created by Vaibhav Gajjar on 26/12/24.
//
import Foundation
import Combine

class RacingListViewModel: ObservableObject {
    
    // Published properties to update the UI
    @Published var allRaces: [Race] = []  // All fetched races
    @Published var races: [Race] = []    // Filtered and sorted races
    @Published var selectedCategories: Set<String> = [] { // Selected filter categories
        didSet {
            updateRaceList()
        }
    }
    @Published var errorMessage: String? // Error message for UI
    
    private var refreshTask: Task<Void, Never>? // Task for periodic data refresh
    private let apiService: Networking!       // Instance of API service
    
    init(service: Networking) {
        self.apiService = service
        // Auto refresh races and also start periodic refresh
        startAutoRefresh()
    }
    
    // MARK: - Fetch Races
    func fetchRaces() async {
        do {
            let fetchedRaces = try await apiService.fetchRaces(count: AppConstants.maxRacesToDisplay)
            
            // Filter out races past their start time and sort by start time
            let filteredRaces = fetchedRaces.filter { $0.advertisedStart.isWithinLastMinute() }
                .sorted(by: { $0.advertisedStart < $1.advertisedStart })
            
            Task { @MainActor in
                // Update properties on the main thread
                allRaces = filteredRaces
                updateRaceList()
            }
        } catch {
            Task { @MainActor in
                // Handle errors by updating the error message
                errorMessage = "Failed to load races: \(error.localizedDescription)"
            }
        }
    }
    
    // MARK: - Update Race List Based on Filters
    func updateRaceList() {
            races = allRaces.filter { race in
                // Apply category filters and exclude past races
                (selectedCategories.isEmpty || selectedCategories.contains(race.categoryId)) &&
                race.advertisedStart.isWithinLastMinute()
            }
            .sorted(by: { $0.advertisedStart < $1.advertisedStart }) // Sort by start time
    }
    
    // MARK: - Start Auto Refresh
    func startAutoRefresh() {
        // Refresh data every 30 seconds
        refreshTask = Task {
            while !Task.isCancelled {
                await fetchRaces()
                try? await Task.sleep(nanoseconds: AppConstants.refreshInterval * 1_000_000_000)
            }
        }
    }
    
    deinit {
        refreshTask?.cancel()
    }
    
    // MARK: - Helper Methods
    // Check whether filter is already applied or not
    func isCategorySelected(_ categoryId: String) -> Bool {
        return selectedCategories.contains(categoryId)
    }
    
    // Apply / Remove filter with given categoryId
    func toggleCategorySelection(_ categoryId: String) {
        if selectedCategories.contains(categoryId) {
            selectedCategories.remove(categoryId)
        } else {
            selectedCategories.insert(categoryId)
        }
        updateRaceList() // Update the race list when filters change
    }
}
