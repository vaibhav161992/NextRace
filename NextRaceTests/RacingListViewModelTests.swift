//
//  NextRaceTests.swift
//  NextRaceTests
//
//  Created by Vaibhav Gajjar on 26/12/24.
//

import XCTest
@testable import NextRace

final class RacingListViewModelTests: XCTestCase {
    var viewModel: RacingListViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = RacingListViewModel(service: MockAPIService())
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func mockRaces() -> [Race] {
        return [
            Race(id: "1", meetingName: "Melbourne", raceNumber: 1, advertisedStart: Date().addingTimeInterval(300), categoryId: AppConstants.horseCatrgoryID),
            Race(id: "2", meetingName: "Sydney", raceNumber: 2, advertisedStart: Date().addingTimeInterval(-120), categoryId: AppConstants.harnessCatrgoryID),
            Race(id: "3", meetingName: "Brisbane", raceNumber: 3, advertisedStart: Date().addingTimeInterval(600), categoryId: AppConstants.greyHoundCatrgoryID)
        ]
    }
    
    func testExpiredRacesAreExcluded() {
            viewModel.allRaces = mockRaces()
            viewModel.updateRaceList()
            XCTAssertEqual(viewModel.races.count, 2) // Only two races are not expired
            XCTAssertFalse(viewModel.races.contains { $0.id == "2" }) // Expired race is excluded
    }
    
    func testFilteringByCategory() {
        viewModel.allRaces = mockRaces()
        viewModel.selectedCategories = [AppConstants.horseCatrgoryID]
        viewModel.updateRaceList()

        XCTAssertEqual(viewModel.races.count, 1) // Only one race matches the filter
        XCTAssertEqual(viewModel.races.first?.categoryId, AppConstants.horseCatrgoryID)
    }
    
    func testSortingByAdvertisedStart() {
        viewModel.allRaces = mockRaces()
        viewModel.updateRaceList()

        XCTAssertTrue(viewModel.races[0].advertisedStart < viewModel.races[1].advertisedStart)
    }
    
    func testFetchingRaces() async {
        let mockService = MockAPIService()
        viewModel = RacingListViewModel(service: mockService)
        await viewModel.fetchRaces()
        XCTAssertTrue(mockService.isServiceCalled) 
    }
}
