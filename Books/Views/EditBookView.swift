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
    @State private var recommendedBy: String = ""
    @State private var dateAdded: Date = Date.distantPast
    @State private var dateStarted: Date = Date.distantPast
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
                                   in: ...Date(),
                                   displayedComponents: .date)
                    }
                    if status == .reading || status == .completed {
                        LabeledContent("Started date") {
                            DatePicker("", selection: $dateStarted, in: dateAdded...Date(),
                                       displayedComponents: .date)
                        }
                    }
                    if status == .completed {
                        LabeledContent("Completed date") {
                            DatePicker("", selection: $dateCompleted,
                                       in: dateStarted...Date(),
                                       displayedComponents: .date)
                        }
                    }
                }
                .onChange(of: status) { oldValue, newValue in
                    if !isFirstTime {
                        if newValue == .toRead {
                            dateStarted = Date.distantPast
                            dateCompleted = Date.distantPast
                            
                        } else if newValue == .reading, oldValue == .completed {
                            dateCompleted = Date.distantPast
                        } else if newValue == .reading, oldValue == .toRead {
                            dateStarted = Date.now
                        } else if newValue == .completed, oldValue == .toRead {
                            dateCompleted = Date.now
                            dateStarted = dateAdded
                        } else {
                            dateCompleted = Date.now
                        }
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
                    //Recommended by
                    LabeledContent {
                        TextField("Unknown", text: $recommendedBy)
                            .multilineTextAlignment(.trailing)
                    } label: {
                        Text("RecommendedBy:").foregroundStyle(.secondary)
                    }
                    Divider()
                    Text("Summary:")
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextEditor(text: $summary)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 0.5))
                    NavigationLink(destination: QuotationListView(book: book)) {
                        let count = book.quote?.count ?? 0
                        Label("^[\(count) Quote](inflect: true)", systemImage: "quote.opening")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .padding()
                .navigationTitle(book.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button("Update") {
                        book.title = title
                        book.author = author
                        book.dateAdded = dateAdded
                        book.dateStarted = dateStarted
                        book.dateCompleted = dateCompleted
                        book.rating = rating
                        book.status = status
                        book.summary = summary
                        book.recommendedBy = recommendedBy
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
            dateStarted = book.dateStarted
            dateCompleted = book.dateCompleted
            rating = book.rating
            status = book.status
            summary = book.summary
            recommendedBy = book.recommendedBy
        }
    }
    private var hasChanges: Bool {
        return book.title != title ||
        book.author != author ||
        book.summary != summary ||
        book.rating != rating ||
        book.status != status ||
        book.dateAdded != dateAdded ||
        book.dateStarted != dateStarted ||
        book.dateCompleted != dateCompleted ||
        book.recommendedBy != recommendedBy
    }
}

#Preview {
    let preview = Preview(Book.self)
    
    NavigationStack {
        EditBookView(book: Book.sampleBooks[4])
            .modelContainer(preview.container)
    }
}
