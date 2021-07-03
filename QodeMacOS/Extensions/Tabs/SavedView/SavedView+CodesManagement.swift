//
//  SavedView+CodesManagement.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 24/06/2021.
//

import Foundation

// MARK: - Codes Management
extension SavedView {
    func filterCodes(_ code: SavedCode) -> Bool {
        let date = DataManager.dateFormatter.string(from: code.date ?? Date())
        
        return searchText.isEmpty ? true :
        code.title.contains(searchText.lowercased()) ||
        code.language.contains(searchText.lowercased()) ||
        code.code.contains(searchText.lowercased()) ||
        date.contains(searchText.lowercased())
    }
}
