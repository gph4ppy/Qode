//
//  SideMenuButton.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 28/05/2021.
//

import SwiftUI

struct SideMenuButton: View {
    // Properties
    let title: String
    let imageName: String
    @Binding var selectedTab: String
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.selectedTab = title
            }
        }) {
            HStack(alignment: .center, spacing: 2) {
                Spacer()
                Image(systemName: imageName)
                Text(title)
                Spacer()
            }
            .padding()
            .background(Color(selectedTab == title ? NSColor.gray : NSColor.systemGray))
            .clipShape(Capsule())
        }
        .foregroundColor(selectedTab == title ? .black : .white)
        .buttonStyle(PlainButtonStyle())
    }
}
