//
//  RatingsView.swift
//  Books
//
//
import SwiftUI

struct RatingsView: View {
    var totoalRatingCount: Int
    @Binding var currentRating: Int?
    var color: Color = .yellow
    var body: some View {
        VStack {
            HStack {
                ForEach(1...totoalRatingCount, id: \.self) { rating in
                    Image(systemName: "star")
                        .symbolVariant(checkRating(rating) ? .fill :.none)
                        .foregroundStyle(color)
                        .onTapGesture {
                            withAnimation {
                                currentRating = rating
                            }
                        }
                }
            }
        }
    }
    
    func checkRating(_ rating: Int) -> Bool {
        guard let currentRating = currentRating else {
            return false
        }
        return rating <= currentRating
    }
}
