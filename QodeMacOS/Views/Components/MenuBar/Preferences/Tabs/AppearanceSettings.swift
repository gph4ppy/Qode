//
//  AppearanceSettings.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 02/07/2021.
//

import SwiftUI

struct AppearanceSettings: View {
    // Properties
    @State private var showingPopover: Bool = false
    @State private var selectedColor: Color = .yellow
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("theme") var selectedTheme = "paraiso-dark"
    @AppStorage("darkMode") var darkMode = "System"
    var darkModeSettings = ["On", "Off", "System"]
    
    var body: some View {
        Form {
            Section(header: Text(LocalizedStrings.appearance)
                        .foregroundColor(.gray)
            ) {
                // Dark Mode
                HStack(spacing: 10) {
                    Text("Dark Mode:")
                    Spacer()
                    MenuButton(label: Text("Dark Mode")) {
                        ForEach(darkModeSettings, id: \.self) { setting in
                            Button(action: {
                                self.darkMode = setting
                            }) {
                                Text(setting)
                            }
                        }
                    }
                    .frame(width: 200)
                }
                
                // Theme
                HStack(spacing: 10) {
                    Text("Theme:")
                    Spacer()
                    MenuButton(label: Text(selectedTheme)) {
                        if let themes = TextView.highlightr?.availableThemes() {
                            ForEach(themes, id: \.self) { theme in
                                Button(action: {
                                    self.selectedTheme = theme
                                    TextView.highlightr?.setTheme(to: theme)
                                }) {
                                    Text(theme)
                                }
                            }
                        }
                    }
                    .frame(width: 200)
                }
                
                // Scanner Area Color
                HStack(spacing: 10) {
                    Text("Scanner Area:")
                    Spacer()
                    Button(action: {
                        self.showingPopover.toggle()
                    }) {
                        Text("Color")
                            .frame(width: 184)
                    }
                    .popover(isPresented: $showingPopover) {
                        ColorPicker("Select Color", selection: $selectedColor)
                            .padding()
                    }
                }
            }
            
            Section(header: Text("Editor").foregroundColor(.gray)) {
                
            }
            .padding(.top)
        }
        .frame(width: 300)
        .padding()
    }
}

struct AppearanceSettings_Previews: PreviewProvider {
    static var previews: some View {
        AppearanceSettings()
    }
}
