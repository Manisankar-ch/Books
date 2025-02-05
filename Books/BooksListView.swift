//
//  ContentView.swift
//  Books
//
//  
//

import SwiftUI
import SwiftData

struct BooksListView: View {
    @Query var books: [Book]
    @State private var showAddBookSheet = false
    @State private var sortStatus: SortOrder = .author
    @State private var searchText: String = ""
    var body: some View {
        NavigationStack {
            if !books.isEmpty {
                HStack {
                    Picker("Status", selection: $sortStatus) {
                        ForEach(SortOrder.allCases) { status in
                            Text("Sory by \(status.rawValue)").tag(status)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            BookList(sortStatus: sortStatus, filter: searchText)
               
                .showSearchBar(!books.isEmpty, text: $searchText, placeHolderText: "Filter on title or author")
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
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    return BooksListView()
        .modelContainer(preview.container)
}


extension View {
    func showSearchBar(_ show: Bool, text: Binding<String>, placeHolderText: String) -> some View {
        modifier(ShowSearchBar(show: show, text: text, placeHolderText: placeHolderText))
       }
}

struct ShowSearchBar: ViewModifier {
    let show: Bool
    @Binding var text: String
    var placeHolderText: String
    func body(content: Content) -> some View {
        if show {
             content
                .searchable(text: $text , prompt: Text(placeHolderText))
        } else {
            content
        }
    }
}
