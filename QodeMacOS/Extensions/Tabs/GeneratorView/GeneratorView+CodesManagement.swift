//
//  GeneratorView+CodesManagement.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 14/06/2021.
//

import SwiftUI

// MARK: - Codes Management
extension GeneratorView {
    /// This method shows the View which has a QR code generated.
    func generateQRCode() {
        let code = TextView.textStorage.string
        
        DispatchQueue.main.async { [self] in
            if code.count > 2200 {
                // Check if the code is not empty.
                self.title = LocalizedStrings.tooLongCodeTitle
                self.message = LocalizedStrings.tooLongCodeBody
                self.action = LocalizedStrings.ok
                self.showingErrorAlert = true
            } else if code.count == 0 {
                // Check if the code is not empty.
                self.title = LocalizedStrings.emptyCodeTitle
                self.message = LocalizedStrings.emptyCodeBody
                self.action = LocalizedStrings.ok
                self.showingErrorAlert = true
            } else if checkForIllegalCharacters(string: code) || code.containsEmoji {
                // Check if the code does not contain illegal characters.
                self.title = LocalizedStrings.illegalCharTitle
                self.message = LocalizedStrings.illegalCharBody
                self.action = LocalizedStrings.ok
                self.showingErrorAlert = true
            } else {
                // Show View with generated QR code - everything is ok.
                QRCodeView(code: $code)
                    .frame(width: 400, height: 400)
                    .environment(\.managedObjectContext, viewContext)
                    .preferredColorScheme(darkMode == "System" ? colorScheme : (darkMode == "On" ? .dark : .light))
                    .openInWindow(title: LocalizedStrings.yourSavedCode, sender: self)
            }
        }
    }
    
    /// This method checks if the code contains illegal characters.
    /// - Parameter string: Code which will be checked
    /// - Returns: Bool value if string contains illegal character
    private func checkForIllegalCharacters(string: String) -> Bool {
        if string.rangeOfCharacter(from: AppData.illegalCharacters) != nil {
            // Found illegal characters
            return true
        } else {
            // Didn't find illegal characters
            return false
        }
    }
}
