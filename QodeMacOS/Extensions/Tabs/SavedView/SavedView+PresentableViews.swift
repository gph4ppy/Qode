//
//  SavedView+PresentableViews.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 24/06/2021.
//

import SwiftUI

// MARK: - Presentable Views
extension SavedView {
    // NavBar
    @ViewBuilder var navBar: some View {
        ZStack {
            Text(LocalizedStrings.savedCodes)
                .font(.system(size: 25, weight: .bold, design: .default))
            
            HStack {
                Button(isEditing ? LocalizedStrings.save : LocalizedStrings.edit) {
                    if isEditing { PersistenceController.shared.saveContext() }
                    self.isEditing.toggle()
                }
                .padding(.leading)
                
                Spacer()
                
                SearchBar(text: $searchText)
                    .frame(width: 150)
                    .padding(.leading)
            }
        }
    }
}
