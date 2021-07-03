//
//  MenuViewModel.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 31/05/2021.
//

import Foundation

class MenuViewModel: ObservableObject {
    @Published var selectedMenuTab: String = "Menu"
    @Published var selectedPreferencesTab: String = LocalizedStrings.appearance
}
