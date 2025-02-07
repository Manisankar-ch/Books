//
//  newGenre.swift
//  Books
//
//

import SwiftUI


struct GenreStackView: View {
    var genres: [Genres]
    var body: some View {
        HStack() {
            ForEach(genres.sorted(using: KeyPathComparator(\Genres.name))) { gerne in
                Text(gerne.name)
                    .font(.caption)
                    .foregroundStyle(.white)
                    .padding(5)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                        .fill(gerne.hexColor)
                    )
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

