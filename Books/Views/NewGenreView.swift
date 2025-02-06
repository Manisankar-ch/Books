//
//  NewGenreView.swift
//  Books
//
//  Created by Softsuave-iOS dev on 06/02/25.
//
import SwiftUI
import SwiftData

struct NewGenreView: View {
    
    @State private var name: String = ""
    @State private var color = Color.red
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Form {
            TextField("Name", text: $name)
            ColorPicker("Color", selection: $color, supportsOpacity: false)
            Button("Create") {
                let newGenre = Genres(name: name.trim(), color: color.toHexString()!)
                context.insert(newGenre)
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .disabled(name.trim().isEmpty)
            .padding()
            .navigationTitle("New genre")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}


#Preview {
    NewGenreView()
}
