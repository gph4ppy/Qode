//
//  AppMenu.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 17/06/2021.
//

import AppKit
import SwiftUI

class AppMenu: NSMenu {
    // Properties
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("darkMode") var darkMode = "System"
    
    // Preferences
    @IBAction func preferencesTapped(_ sender: NSMenuItem) {
        PreferencesView()
            .frame(width: 600, height: 400)
            .preferredColorScheme(darkMode == "System" ? colorScheme : (darkMode == "On" ? .dark : .light))
            .openInWindow(title: "Preferences", sender: self)
    }
}
