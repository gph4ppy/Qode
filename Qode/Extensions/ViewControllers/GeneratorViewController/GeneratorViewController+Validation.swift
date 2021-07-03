//
//  GeneratorViewController+Validation.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 01/05/2021.
//

import Foundation

// MARK: - Validation
extension GeneratorViewController {
    /// This method checks if the code contains illegal characters.
    /// - Parameter string: Code which will be checked
    /// - Returns: Bool value if string contains illegal character
    func checkForIllegalCharacters(string: String) -> Bool {
        if string.rangeOfCharacter(from: AppData.illegalCharacters) != nil {
            // Found illegal characters
            return true
        } else {
            // Didn't find illegal characters
            return false
        }
    }
}
