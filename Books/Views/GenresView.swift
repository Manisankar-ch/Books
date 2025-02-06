//
//  GenresView.swift
//  Books
//
import SwiftUI
import SwiftData

struct GenresView: View {
    @Query(sort: \Genres.name) var genres: [Genres]
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Bindable var book: Book
    @State private var newGenre: Bool = false
    var body: some View {
        NavigationStack {
            Group {
                if genres.isEmpty {
                    ContentUnavailableView {
                        Image(systemName: "bookmark.fill")
                    } description : {
                        Text("Add new genres")
                    } actions : {
                        Button("Create genre") {
                            newGenre.toggle()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    List {
                        ForEach(genres) { genre in
                            HStack {
                                if let bookGenres = book.genres {
                                    if bookGenres.isEmpty {
                                        Button {
                                            addRemove(genre)
                                        } label: {
                                            Image(systemName: "circle")
                                        }
                                        .foregroundStyle(genre.hexColor)
                                    } else {
                                        Button {
                                            addRemove(genre)
                                        } label: {
                                            Image(systemName: bookGenres.contains(genre) ? "circle.fill" : "circle")
                                        }
                                        .foregroundStyle(genre.hexColor)
                                    }
                                }
                                Text(genre.name)
                            }
                        }
                        .onDelete { indexSet in
                            
                            for index in indexSet {
                                if let bookGenres = book.genres,
                                   let bookGenreIndex = bookGenres.firstIndex(where: { $0.id == genres[index].id }) {
                                    book.genres?.remove(at: bookGenreIndex)
                                }

                                context.delete(genres[index])
                            }
                        }
                        LabeledContent {
                            Button {
                                newGenre.toggle()
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .imageScale(.large)
                            }
                            .buttonStyle(.borderedProminent)
                        } label: {
                            Text("Create a new Genre")
                                .font(.caption)
                        }
                        .padding()
                    }
                }
            }
            .sheet(isPresented: $newGenre) {
                NewGenreView()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back") {
                        dismiss()
                    }
                }
            }
            .toolbarTitleDisplayMode(.inline)
            .navigationTitle(book.title)
        }
    }
    
    func addRemove(_ genre: Genres) {
        if let bookGenres = book.genres {
            if bookGenres.contains(genre) {
                book.genres?.removeAll { $0.id == genre.id }
            } else {
                book.genres?.append(genre)
            }
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    let books = Book.sampleBooks
    let genres = Genres.sample
    preview.addExamples(books)
    preview.addExamples(genres)
    books[4].genres?.append(genres[0])
    return GenresView(book: books[4])
        .modelContainer(preview.container)
}
