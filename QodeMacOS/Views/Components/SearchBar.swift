//
//  SearchBar.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 14/06/2021.
//

import SwiftUI

struct SearchBar: View {
    // Properties
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField(LocalizedStrings.search, text: $text)
        }
        .padding(5)
        .background(Color(NSColor.lightGray))
        .clipShape(Capsule())
        .textFieldStyle(PlainTextFieldStyle())
    }
}
