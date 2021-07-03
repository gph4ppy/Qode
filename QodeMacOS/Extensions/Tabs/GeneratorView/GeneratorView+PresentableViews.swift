//
//  GeneratorView+PresentableViews.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 14/06/2021.
//

import SwiftUI

// MARK: - Presentable Views
extension GeneratorView {
    /// This method creates the NavBar.
    /// - Returns: Navigation Bar
    @ViewBuilder func makeNavBar() -> some View {
        ZStack {
            // Characters counter
            HStack {
                Text("\(code.count)/2200 \(LocalizedStrings.characters)")
                    .foregroundColor(code.count >= 2200 ? .red : .primary)
                Spacer()
                
            }
            
            // Title
            Text(LocalizedStrings.generateCode)
                .font(.system(size: 25, weight: .bold, design: .default))
            
            // Language button
            HStack(spacing: 10) {
                Spacer()
                
                Button(LocalizedStrings.language) {
                    LanguageActionSheet()
                        .frame(width: 400, height: 600)
                        .preferredColorScheme(darkMode == "System" ? colorScheme : (darkMode == "On" ? .dark : .light))
                        .openInWindow(title: LocalizedStrings.languageTitle, sender: self)
                }
                
                // Generate button
                Button(LocalizedStrings.generate) {
                    generateQRCode()
                }
            }
        }
        .navBarModifier()
    }
}
