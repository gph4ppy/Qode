//
//  MenuView+PresentableViews.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 14/06/2021.
//

import SwiftUI

// MARK: - Presentable Views
extension MenuView {
    /// This method creates the side bar menu.
    /// - Returns: Side Bar Menu
    @ViewBuilder func makeSideBar() -> some View {
        VStack {
            // Logo
            Image("Logo")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
            
            // Buttons
            VStack(spacing: 15) {
                makeSideBarButtons()
                
                Spacer()
                
                Text("\(String(year)) | Jakub Dąbrowski")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .frame(minWidth: size.width / 10)
        .padding()
    }
    
    /// This method creates the buttons which will be used in the Side Bar.
    /// - Returns: Side bar Buttons
    @ViewBuilder func makeSideBarButtons() -> some View {
        ForEach(MainMenuTab.allCases, id: \.self) { tab in
            if tab.data.title != MainMenuTab.menu.data.title {
                SideMenuButton(title: tab.data.title,
                               imageName: tab.data.imageName,
                               selectedTab: $menuVM.selectedMenuTab)
            }
        }
    }
}
