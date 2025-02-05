//
//  BooksApp.swift
//  Books
//
//  
//

import SwiftUI
import SwiftData

@main
struct BooksApp: App {
    let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            BooksListView()
        }
        .modelContainer(container)
       
    }
    
    init() {
        let schema = Schema([Book.self])
        let config = ModelConfiguration("MyBooks", schema: schema)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError(error.localizedDescription)
        }
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
