//
//  Genres.swift
//  Books
//
//

import SwiftData
import SwiftUICore

@Model
class Genres {
    var name: String
    var color: String
    var books: [Book]?
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
    var hexColor: Color {
        Color(hex: self.color) ?? .red
    }
}
