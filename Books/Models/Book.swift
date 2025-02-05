//
//  Model.swift
//  Books
//
//  
//
import SwiftUI
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var dateAdded: Date
    var dateStarted: Date
    var dateCompleted: Date
    var summary: String
    var rating: Int?
    var recommendedBy: String = ""
    @Relationship(deleteRule: .cascade)
    var quote: [Quote]?
    
    @Attribute()
    var statusRawValue: Int = 0
    var status: Status {
        get {
            Status(rawValue: statusRawValue) ?? .toRead
        }
        set {
            statusRawValue = newValue.rawValue
        }
    }
    
    var icon: Image {
        switch status {
        case .toRead:
            Image(systemName: "checkmark.diamond.fill")
        case .reading:
            Image(systemName: "book.fill")
        case .completed:
            Image(systemName: "books.vertical.fill")
        }
    }
    
    init(title: String,
         author: String,
         dateAdded: Date = Date.now,
         dateStarted: Date = Date.distantPast,
         dateCompleted: Date = Date.distantPast,
         summary: String = "",
         rating: Int? = nil,
         status: Status = .toRead,
         recommendedBy: String = ""
    ) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.summary = summary
        self.rating = rating
        self.status = status
        self.statusRawValue = status.rawValue
        self.recommendedBy = recommendedBy
    }
}

enum Status: Int, Codable, Identifiable, CaseIterable {
    case toRead, reading, completed
    
    var id: Self {
        self
    }
    
    var description: String {
        switch(self) {
        case .toRead:
            "To read"
        case .reading:
            "Reading"
        case .completed:
            "Completed"
        }
    }
}

enum SortOrder: String, CaseIterable, Identifiable {
    case status, title, author
    var id: Self {
        self
    }
}
