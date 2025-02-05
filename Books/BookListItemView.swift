//
//  BookListItemView.swift
//  Books
//
//

import SwiftUI

struct BookListItemView: View {
    var book: Book
    var body: some View {
        HStack {
            book.icon
            VStack {
                Text(book.title)
                Text(book.author)
            }
            Spacer()
            VStack {
                Spacer()
                HStack {
                    ForEach(0..<(book.rating ?? 0), id: \.self) {_ in
                        Image(systemName: "star.fill")
                            .resizable()
                            .imageScale(.medium)
                            .foregroundStyle(.yellow)
                            .frame(width: 15, height: 15)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    var book = Book(title: "Test", author: "test")
    BookListItemView(book: book)
}
