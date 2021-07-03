//
//  DataManager.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 16/06/2021.
//

import Foundation

struct DataManager {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .long
        return formatter
    }()
}
