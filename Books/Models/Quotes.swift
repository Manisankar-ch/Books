//
//  Quote.swift
//  Books
//
//

import SwiftData
import SwiftUI

@Model
class Quote {
    var createdAt: Date = Date.now
    var page: String?
    var text: String
    init(page: String? = nil, text: String) {
        self.page = page
        self.text = text
    }
    var book: Book?
}
