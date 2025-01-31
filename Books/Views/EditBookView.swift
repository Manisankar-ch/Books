//
//  EditBookView.swift
//  Books
//
//
//

import SwiftUI

struct EditBookView: View {
    @Environment(\.dismiss) private var dismiss
    var book: Book
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var dateAdded: Date = Date.distantPast
    @State private var dateStared: Date = Date.distantPast
    @State private var dateCompleted: Date = Date.distantPast
    @State private var summary: String = ""
    @State private var rating: Int?
    @State private var status: Status = .toRead
    @State private var isFirstTime: Bool = true
    var body: some View {
        NavigationStack {
            HStack {
                Text("Status")
                Picker("Status", selection: $status) {
                    ForEach(Status.allCases) { status in
                        Text(status.description).tag(status)
                    }
                }
                .buttonStyle(.borderedProminent)
                
            }
            VStack {
                GroupBox {
                    LabeledContent("Added date") {
                        DatePicker("", selection: $dateAdded,
                                   displayedComponents: .date)
                    }
                    if book.status == .reading || book.status == .completed {
                        LabeledContent("Started date") {
                            DatePicker("", selection: $dateStared,
                                       displayedComponents: .date)
                        }
                    }
                    if book.status == .completed {
                        LabeledContent("Completed date") {
                            DatePicker("", selection: $dateCompleted,
                                       displayedComponents: .date)
                        }
                    }
                }
                .onChange(of: book.status) { onValue, newValue in
                    if !isFirstTime {
                        
                    }
                    isFirstTime = false
                }
                Divider()
                VStack(spacing: 10) {
                    LabeledContent("Rating") {
                        RatingsView(totoalRatingCount: 5, currentRating: $rating)
                    }
                    LabeledContent {
                        TextField("Title", text: $title)
                            .multilineTextAlignment(.trailing)
                        
                    } label: {
                        Text("Title").foregroundStyle(.secondary)
                    }
                    
                    LabeledContent {
                        TextField("Author", text: $author)
                            .multilineTextAlignment(.trailing)
                    } label: {
                        Text("Author").foregroundStyle(.secondary)
                    }
                    Divider()
                    Text("Summary:")
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextEditor(text: $summary)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 0.5))
                }
                .padding()
                .navigationTitle(book.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button("Update") {
                        book.title = title
                        book.author = author
                        book.dateAdded = dateAdded
                        book.dateStared = dateStared
                        book.dateCompleted = dateCompleted
                        book.rating = rating
                        book.status = status
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(!hasChanges)
                }
            }
        }
        .onAppear {
            title = book.title
            author = book.author
            dateAdded = book.dateAdded
            dateStared = book.dateStared
            dateCompleted = book.dateCompleted
            rating = book.rating
            status = book.status
        }
    }
    private var hasChanges: Bool {
        return book.title != title ||
        book.author != author ||
        book.summary != summary ||
        book.rating != rating ||
        book.status != status ||
        book.dateAdded != dateAdded ||
        book.dateStared != dateStared ||
        book.dateCompleted != dateCompleted
    }
}

#Preview {
    @Previewable @State var book = Book(title: "title", author: "author", dateAdded: Date.distantPast, dateStared: Date.distantPast, dateCompleted: Date.distantPast, summary: "summary", rating: 2, status: .reading)
    NavigationStack {
        EditBookView(book: book)
    }
}
