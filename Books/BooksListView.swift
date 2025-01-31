//
//  ContentView.swift
//  Books
//
//  
//

import SwiftUI
import SwiftData

struct BooksListView: View {
    @Environment(\.modelContext) var context
    @Query(sort: \Book.title) var books: [Book]
    @State private var showAddBookSheet = false
    var body: some View {
        NavigationStack {
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
            .navigationTitle("My Books")
            .toolbar {
                Button {
                    showAddBookSheet.toggle()
                } label: {
                    Image(systemName: "plus.circle.dashed")
                        .imageScale(.large)
                    
                }
            }
            
            .sheet(isPresented: $showAddBookSheet) {
                NewBookView()
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
//    BookListItemView(book: Book(title: "test", author: "author"))
    BooksListView()
}

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
