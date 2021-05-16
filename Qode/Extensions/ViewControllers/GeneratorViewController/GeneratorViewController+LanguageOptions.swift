//
//  GeneratorViewController+LanguageOptions.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 01/05/2021.
//

import UIKit

// MARK: - Language Options
extension GeneratorViewController {
    /// This method setups the language, thanks to which the code syntax is highlighted.
    /// - Returns: NSAttributedString which will be assigned to TextView
    @discardableResult internal func setupLanguage() -> NSAttributedString? {
        textStorage.language = selectedLanguage.capitalizingFirstLetter()
        return highlightr?.highlight(textStorage.string, as: selectedLanguage)
    }
    
    /// This method changes the currently selected language so the code syntax can be highlighted.
    @objc internal func changeLanguage() {
        let device = UIDevice.current.userInterfaceIdiom
        
        DispatchQueue.main.async {
            // Create sheet
            let ac = UIAlertController(title: LocalizedStrings.language,
                                       message: LocalizedStrings.selectLanguageBody,
                                       preferredStyle: device == .pad ? .alert : .actionSheet)
            
            // Add all languages actions
            self.highlightr?.supportedLanguages().forEach({ language in
                ac.addAction(UIAlertAction(title: language.capitalizingFirstLetter(), style: .default, handler: { _ in
                    self.selectedLanguage = language
                    self.setupLanguage()
                }))
            })
            
            // Add cancel action
            ac.addAction(UIAlertAction(title: LocalizedStrings.cancel, style: .destructive))
            
            // Present alert controller
            self.present(ac, animated: true)
        }
    }
}
