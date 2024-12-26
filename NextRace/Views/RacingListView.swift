//
//  ContentView.swift
//  NextRace
//
//  Created by Vaibhav Gajjar on 26/12/24.
//

import SwiftUI

struct RacingListView: View {
    @StateObject private var viewModel = RacingListViewModel(service: APIService())
    @State var isRacesLoading = true


    var body: some View {
        NavigationView {
            ZStack {

                VStack {
                    // Filter View with 3 racing filters
                    FilterView(selectedCategories: $viewModel.selectedCategories)

                    // Race list from API
                    List(viewModel.races) { race in
                        RaceRow(race: race)
                    }
                    .listStyle(PlainListStyle())
                    .refreshable {
                        await viewModel.fetchRaces()
                    }
                    .overlay {
                        if viewModel.races.isEmpty {
                            ContentUnavailableView("No Race Found", systemImage: "exclamationmark.triangle.fill")
                        }
                    }
                }

                ActivityIndicator(isAnimating: $isRacesLoading, style: .large)
            }
            .task {
                isRacesLoading = true
                await viewModel.fetchRaces()
                isRacesLoading = false
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil), actions: {
                Button("OK", role: .cancel) { viewModel.errorMessage = nil }
            }, message: {
                Text(viewModel.errorMessage ?? "")
            })
            .navigationTitle("Racing")
        }
    }
}

#Preview {
    RacingListView()
}
