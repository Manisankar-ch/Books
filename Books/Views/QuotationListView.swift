//
//  QuotationListView.swift
//  Books
//
//

import SwiftUI

struct QuotationListView: View {
    var book: Book
    @State private var selectedQuote: Quote?
    @Environment(\.modelContext) private var context
    var isEditing: Bool {
        selectedQuote != nil
    }
    @State private var quote = ""
    @State private var page: String = ""
    var body: some View {
        Group {
            HStack {
                LabeledContent("Page") {
                    TextField("", text: $page)
                        .border(Color.secondary)
                        .frame(width: 80)
                    Spacer()
                }
                if isEditing {
                    Button("Cancel") {
                        page = ""
                        quote = ""
                        selectedQuote = nil
                    }
                    .buttonStyle(.borderedProminent)
                }
                Button(isEditing ? "Update": "Create") {
                    if isEditing {
                        selectedQuote?.text = quote
                        selectedQuote?.page = page
                        page = ""
                        quote = ""
                        selectedQuote = nil
                    } else {
                        let quotation = Quote(page: page, text: quote)
                        book.quote?.append(quotation)
                        quote = ""
                        page = ""
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(quote.isEmpty)
            }
            TextEditor(text: $quote)
                .border(Color.secondary)
                .frame(height: 50)
            
            List {
                ForEach(book.quote ?? []) { quote in
                    VStack(alignment: .leading) {
                        Text(quote.createdAt, format: .dateTime.month().day().year())
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(quote.text)
                        HStack {
                            Spacer()
                            if let page = quote.page, !page.isEmpty {
                                Text("Page: \(page)")
                                
                            }
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedQuote = quote
                        self.quote = quote.text
                        page = quote.page ?? ""
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        self.book.quote!.remove(at: index)
                        
                    }
                }
            }
            .listStyle(.plain)
        }
        .padding(.horizontal)
    }
}

#Preview {
    var book = Book(title: "", author: "")
    QuotationListView(book: book)
}
