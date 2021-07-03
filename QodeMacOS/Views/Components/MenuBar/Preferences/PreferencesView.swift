//
//  PreferencesView.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 17/06/2021.
//

import SwiftUI

struct PreferencesView: View {
    // Properties
    @ObservedObject var menuVM: MenuViewModel = MenuViewModel()
    
    var body: some View {
        VStack {
            HStack(spacing: 14) {
                ForEach(PreferencesMenuTab.allCases, id: \.self) { tab in
                    MenuBarButton(title: tab.data.title,
                                  imageName: tab.data.imageName,
                                  selectedTab: $menuVM.selectedPreferencesTab)
                }
            }
            Divider()
            
            switch menuVM.selectedPreferencesTab {
                case PreferencesMenuTab.appearance.data.title:
                    AppearanceSettings()
                case PreferencesMenuTab.credits.data.title:
                    CreditsSettings()
                case PreferencesMenuTab.about.data.title:
                    AboutSettings()
                default:
                    EmptyView()
            }
            
            Spacer()
        }
        .padding()
    }
}

struct MenuBarButton: View {
    let title: String
    let imageName: String
    @Binding var selectedTab: String
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.selectedTab = title
            }
        }) {
            VStack(spacing: 8) {
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                Text(title)
                    .font(.footnote)
                    .lineLimit(1)
            }
            .contentShape(Rectangle())
            .padding()
            .frame(width: 90, height: 60)
            .background(Color(selectedTab == title ? NSColor.lightGray : NSColor.clear))
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .foregroundColor(selectedTab == title ? .primary : .secondary)
        .buttonStyle(PlainButtonStyle())
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
