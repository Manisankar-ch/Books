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
    var dateStared: Date
    var dateCompleted: Date
    var summary: String
    var rating: Int?
    var status: Status
    
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
         dateStared: Date = Date.distantPast,
         dateCompleted: Date = Date.distantPast,
         summary: String = "",
         rating: Int? = nil,
         status: Status = .toRead
    ) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStared = dateStared
        self.dateCompleted = dateCompleted
        self.summary = summary
        self.rating = rating
        self.status = status
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


protocol Copying {
    init(instance: Self)
}

extension Copying {
    func copy() -> Self {
        return Self.init(instance: self)
    }
}
