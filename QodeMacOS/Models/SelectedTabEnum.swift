//
//  SelectedTabEnum.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 31/05/2021.
//

import Foundation

enum MainMenuTab: CaseIterable {
    case menu
    case generator
    case scanner
    case reader
    case saved
    
    var data: (title: String, imageName: String) {
        switch self {
            case .generator: return (title: LocalizedStrings.generate, imageName: "qrcode")
            case .scanner: return (title: LocalizedStrings.scan, imageName: "qrcode.viewfinder")
            case .reader: return (title: LocalizedStrings.read, imageName: "text.magnifyingglass")
            case .saved: return (title: LocalizedStrings.saved, imageName: "internaldrive")
            default: return (title: "Menu", imageName: "")
        }
    }
}

enum PreferencesMenuTab: CaseIterable {
    case appearance
    case credits
    case about
    
    var data: (title: String, imageName: String) {
        switch self {
            case .appearance: return (title: LocalizedStrings.appearance, imageName: "paintbrush")
            case .credits: return (title: LocalizedStrings.creditsTitle, imageName: "text.badge.star")
            case .about: return (title: LocalizedStrings.about, imageName: "info.circle")
        }
    }
}
