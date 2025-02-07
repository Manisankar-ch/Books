//
//  BookList.swift
//  Books
//
//

import SwiftUI
import SwiftData

struct BookList: View {
    @Environment(\.modelContext) var context
    @Query var books: [Book]
    @State var sortStatus: SortOrder = .status
    
    
    init(sortStatus: SortOrder, filter: String) {
        self.sortStatus = sortStatus
        let sortDescription: [SortDescriptor<Book>] = switch sortStatus {
        case .status:
            [SortDescriptor(\Book.statusRawValue)
             , SortDescriptor(\Book.title)]
        case .title:
            [SortDescriptor(\Book.title)]
        case .author:
            [SortDescriptor(\Book.author)]
        }
        let predicate = #Predicate<Book> { book in
            book.title.localizedStandardContains(filter) ||
            book.author.localizedStandardContains(filter) ||
            filter.isEmpty
            
        }
        _books = Query(filter: predicate, sort: sortDescription)
    }
    
    var body: some View {
        Group {
            if books.isEmpty {
                ContentUnavailableView("Enter your first book", systemImage: "book.fill")
            } else {
                List {
                    ForEach(books) { book in
                        NavigationLink(destination: EditBookView(book: book)) {
                            BookListItemView(book: book)
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let book = self.books[index]
                            context.delete(book)
                            
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    return BookList(sortStatus: .author, filter: "")
        .modelContainer(preview.container)
}
