//
//  AlertPresenterProtocol.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 02/05/2021.
//

import UIKit

protocol AlertPresenter {
    func createAlert(title: String, message: String, action: String) -> UIAlertController
    func createSheet(title: String, message: String, actions data: [String]?, selected option: SelectedOption) -> UIAlertController
}

extension AlertPresenter {
    /// This method creates the alert
    /// - Parameters:
    ///   - title: title of the alert
    ///   - message: message shown below the title of the alert
    ///   - action: action button title
    /// - Returns: alert with the provided data
    func createAlert(title: String, message: String, action: String) -> UIAlertController {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: action, style: .default))
        
        return ac
    }
    
    /// This method creates the alert sheet
    /// - Parameters:
    ///   - title: title of the alert
    ///   - message: message shown below the title of the alert
    ///   - data: an optional array of strings from which the alert actions will be created
    ///   - option: the selected option, from which it is known under which key the data should be saved in UserDefaults
    /// - Returns: alert with the provided data
    func createSheet(title: String, message: String, actions data: [String]?, selected option: SelectedOption) -> UIAlertController {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaults = UserDefaults.standard
        
        if let data = data {
            data.forEach({ action in
                ac.addAction(UIAlertAction(title: action, style: .default, handler: { _ in
                    switch option {
                        case .themeSettings:
                            defaults.set(action, forKey: "theme")
                        case .languageSettings:
                            defaults.set(action, forKey: "language")
                        default:
                            print("The action sheet cannot be displayed with this option.")
                    }
                }))
            })
        }
        
        ac.addAction(UIAlertAction(title: LocalizedStrings.cancel, style: .destructive))
        
        return ac
    }
}
