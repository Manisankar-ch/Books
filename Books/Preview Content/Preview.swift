//
//  Preview.swift
//  Books
//
//  Created by Softsuave-iOS dev on 05/02/25.
//
import Foundation
import SwiftData
import SwiftUICore


struct Preview {
    let container: ModelContainer
    init(_ models: any PersistentModel.Type...) {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let schema = Schema(models)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addExamples( _ sample: [any PersistentModel]) {
        Task {  @MainActor in
            sample.forEach { book in
                container.mainContext.insert(book)
            }
        }
    }
}
