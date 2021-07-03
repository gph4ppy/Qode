//
//  SavedView.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 15/06/2021.
//

import SwiftUI

struct SavedView: View {
    // Properties
    @State var searchText: String      = ""
    @State var isEditing: Bool         = false
    
    // Core Data Properties
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: SavedCode.entity(), sortDescriptors: [])
    var codes: FetchedResults<SavedCode>
    
    var body: some View {
        VStack {
            // NavBar
            navBar
                .navBarModifier()
            
            // Saved List
            List {
                ForEach(codes.filter({ filterCodes($0) }), id: \.self) { code in
                    SavedCodeCard(savedCode: code, isEditing: $isEditing)
                    Divider()
                }
            }
        }
    }
}
