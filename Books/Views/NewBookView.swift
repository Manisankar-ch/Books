//
//  NewBookView.swift
//  Books
//
//  
//

import SwiftUI

struct NewBookView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    @State private var author: String = ""
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                    .accessibilityIdentifier("Title")
                TextField("Author", text: $author)
                    .accessibilityIdentifier("Author")
                Button(action: {
                    print("\(title) \(author)")
                    let book = Book(title: title, author: author)
                    context.insert(book)
                    self.dismiss()
                }) {
                    Text("Create")
                }
                .accessibilityIdentifier("Create")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(.borderedProminent)
                .disabled(title.trim().isEmpty || author.trim().isEmpty)
            }
            .navigationTitle("New Book")
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.red)
                    }
                }
            }
        }
    }
}

#Preview {
    NewBookView()
}
