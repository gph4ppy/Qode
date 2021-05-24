//
//  SavingManager.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 22/05/2021.
//

import UIKit
import Highlightr

class SavingManager: UIViewController, AlertPresenter {
    // Properties
    public var code:              String!
    public var qrCode:            UIImage?
    public var codeTitle:         String?
    public var codeContent:       String?
    public var codeLanguage:      String?
    
    @objc public func saveCode() {
        DispatchQueue.main.async {
            let titleAlert = UIAlertController(title: LocalizedStrings.enterCodeTitle,
                                               message: LocalizedStrings.enterCodeTitleBody,
                                               preferredStyle: .alert)
            
            titleAlert.addTextField { textField in
                textField.placeholder = LocalizedStrings.title
            }
            
            titleAlert.addAction(UIAlertAction(title: LocalizedStrings.save,
                                               style: .default,
                                               handler: { _ in
                                                if let input = titleAlert.textFields?[0].text {
                                                    self.codeTitle = input
                                                    self.setCodeLanguage()
                                                }
                                               }))
            
            titleAlert.addAction(UIAlertAction(title: LocalizedStrings.cancel,
                                               style: .destructive))
            
            self.present(titleAlert, animated: true)
        }
    }
    
    private func setCodeLanguage() {
        if let languages = Highlightr()?.supportedLanguages() {
            let languageAlert = UIAlertController(title: LocalizedStrings.selectLanguageOfSavedCode,
                                                  message: LocalizedStrings.selectLanguageOfSavedCodeBody,
                                                  preferredStyle: .alert)
            
            languages.forEach { language in
                languageAlert.addAction(UIAlertAction(title: language,
                                                      style: .default,
                                                      handler: { _ in
                                                        self.codeLanguage = language
                                                        self.saveContext()
                                                      }))
            }
            
            languageAlert.addAction(UIAlertAction(title: LocalizedStrings.cancel,
                                                  style: .destructive))
            
            present(languageAlert, animated: true)
        }
    }
    
    private func saveContext() {
        let viewContext = PersistenceController.context
        
        guard let image = qrCode,
              let codeTitle = self.codeTitle,
              let codeContent = self.codeContent,
              let codeLanguage = self.codeLanguage else {
            return
        }
        
        let savedCode = SavedCode(context: viewContext)
        
        if let qrCodeData = image.pngData() {
            let savedData = DataToSave(title: codeTitle,
                                       code: codeContent,
                                       qrCode: qrCodeData,
                                       language: codeLanguage,
                                       date: Date())
            
            savedCode.title = savedData.title
            savedCode.language = savedData.language
            savedCode.qrCode = savedData.qrCode
            savedCode.date = savedData.date
            savedCode.code = savedData.code
            
            do {
                try viewContext.save()
                AppData.codes.append(savedCode)
                
                let ac = self.createAlert(title: LocalizedStrings.saved,
                                          message: LocalizedStrings.savedAlertBody,
                                          action: LocalizedStrings.thanks)
                self.present(ac, animated: true)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
