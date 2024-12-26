//
//  FilterView.swift
//  NextRace
//
//  Created by Vaibhav Gajjar on 26/12/24.
//
import SwiftUI

struct FilterView: View {
    @Binding var selectedCategories: Set<String>
    
    let categories: [(String, String)] = [
        ("Horse Racing", AppConstants.horseCatrgoryID),
        ("Harness Racing", AppConstants.harnessCatrgoryID),
        ("Greyhound Racing", AppConstants.greyHoundCatrgoryID)
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(categories, id: \.1) { category in
                    Button(action: {
                        // Filter button action handling
                        if selectedCategories.contains(category.1) {
                            selectedCategories.remove(category.1)
                        } else {
                            selectedCategories.insert(category.1)
                        }
                    }) {
                        Text(category.0)
                            .padding()
                            .background(selectedCategories.contains(category.1) ? Color.orange : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .buttonStyle(.plain)
                    .background(Color.clear)
                    .foregroundColor(.clear)
                    .frame(height: 30)
                }
            }
            .padding()
        }
    }
}
