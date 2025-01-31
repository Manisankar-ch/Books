//
//  String+Extension.swift
//  Books
//
//  
//

extension String {
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
