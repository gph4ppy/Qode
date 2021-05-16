//
//  SettingsViewController+LanguageAndTheme.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 13/05/2021.
//

import Foundation

// MARK: - Language and Theme
extension SettingsViewController {
    @objc func changeTheme() {
        let alert = createSheet(title: LocalizedStrings.theme,
                                message: LocalizedStrings.selectTheme,
                                actions: highlightr?.availableThemes(),
                                selected: .themeSettings)
        
        present(alert, animated: true)
    }
    
    @objc func changeLanguage() {
        let alert = createSheet(title: LocalizedStrings.language,
                                message: LocalizedStrings.selectDefaultLanguage,
                                actions: highlightr?.supportedLanguages(),
                                selected: .languageSettings)
        
        present(alert, animated: true)
    }
}
