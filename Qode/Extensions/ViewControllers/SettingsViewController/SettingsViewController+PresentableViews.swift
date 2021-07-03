//
//  SettingsViewController+SetupTableView.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 13/05/2021.
//

import UIKit

// MARK: - Presentable Views
extension SettingsViewController {
    /// This method configures TableView sections and rows.
    func configure() {
        let device = UIDevice.current.userInterfaceIdiom
        
        self.sections = [
            // MARK: Appearance
            SettingsSection(title: LocalizedStrings.appearance, options: [
                // Theme
                SettingsOption(title: LocalizedStrings.theme,
                               icon: UIImage(systemName: "paintbrush.fill"),
                               iconBackgroundColor: .red,
                               handler: changeTheme),
                
                // Default Language
                SettingsOption(title: LocalizedStrings.defaultLanguage,
                               icon: UIImage(systemName: "keyboard"),
                               iconBackgroundColor: .blue,
                               handler: changeLanguage),
                
                // Scanner area color
                SettingsOption(title: LocalizedStrings.scannerAreaColor,
                               icon: UIImage(systemName: "square.dashed"),
                               iconBackgroundColor: .purple,
                               handler: {
                                self.selectedOption = .scannerAreaColor
                                self.colorPicker.selectedColor = self.scannerAreaColor
                                self.present(self.colorPicker, animated: true)
                               }),
                
                // Accent Color
                SettingsOption(title: LocalizedStrings.accentColor,
                               icon: UIImage(systemName: "eyedropper.full"),
                               iconBackgroundColor: .systemGreen,
                               handler: {
                                self.selectedOption = .accentColor
                                self.colorPicker.selectedColor = self.accentColor
                                self.present(self.colorPicker, animated: true)
                               })
            ]),
            
            // MARK: About
            SettingsSection(title: LocalizedStrings.about, options: [
                // About Qode
                SettingsOption(title: LocalizedStrings.aboutQode,
                               icon: UIImage(systemName: "person.fill.questionmark"),
                               iconBackgroundColor: .lightGray,
                               handler: {
                                let alert = self.createAlert(title: LocalizedStrings.aboutQode,
                                                             message: LocalizedStrings.aboutQodeBody,
                                                             action: LocalizedStrings.cool)
                                self.present(alert, animated: true)
                               }),
                
                // Credits and licenses
                SettingsOption(title: LocalizedStrings.credits,
                               icon: UIImage(systemName: "display.2"),
                               iconBackgroundColor: .gray,
                               handler: {
                                let ac = UIAlertController(title: LocalizedStrings.credits,
                                                           message: LocalizedStrings.creditsBody,
                                                           preferredStyle: device == .pad ? .alert : .actionSheet)
                                
                                // 1 - Highligtr
                                ac.addAction(UIAlertAction(title: "Highlightr", style: .default, handler: { _ in
                                    let alert = self.createAlert(title: "Highlightr",
                                                                 message: LocalizedStrings.highlightrBody,
                                                                 action: LocalizedStrings.ok)
                                    self.present(alert, animated: true)
                                }))
                                
                                // 2 - IQKeyboardManagerSwift
                                ac.addAction(UIAlertAction(title: "IQKeyboardManagerSwift", style: .default, handler: { _ in
                                    let alert = self.createAlert(title: "IQKeyboardManagerSwift",
                                                                 message: LocalizedStrings.iqKeyboardManagerBody,
                                                                 action: LocalizedStrings.ok)
                                    self.present(alert, animated: true)
                                }))
                                
                                ac.addAction(UIAlertAction(title: LocalizedStrings.cancel,
                                                           style: .destructive))
                                
                                self.present(ac, animated: true)
                               }),
                
                // Illegal Characters
                SettingsOption(title: LocalizedStrings.illegalCharacters,
                               icon: UIImage(systemName: "exclamationmark.shield.fill"),
                               iconBackgroundColor: .darkGray,
                               handler: {
                                let alert = self.createAlert(title: LocalizedStrings.illegalCharacters,
                                                             message: LocalizedStrings.illegalCharactersBody,
                                                             action: LocalizedStrings.thanks)
                                
                                self.present(alert, animated: true)
                               }),
                
                // App Version
                SettingsOption(title: LocalizedStrings.version,
                               icon: UIImage(systemName: "doc.badge.gearshape.fill"),
                               iconBackgroundColor: .darkText,
                               handler: {
                                let appVersionBundleKey = "CFBundleShortVersionString"
                                guard let appVersion = Bundle.main.infoDictionary?[appVersionBundleKey] as? String else { return }
                                
                                let alert = self.createAlert(title: LocalizedStrings.version,
                                                             message: appVersion,
                                                             action: LocalizedStrings.ok)
                                
                                self.present(alert, animated: true)
                               })
            ])
        ]
    }
    
    // This method detects when the screen is rotated.
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        loadTableView()
    }
}
