//
//  ScannedCodeViewController.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 21/04/2021.
//

import UIKit
import Highlightr

final class ScannedCodeViewController: SavingManager {
    // Outlets
    @IBOutlet var paddingView:      UIView!
    
    // Properties
    let highlightr                  = Highlightr()
    let textStorage                 = CodeAttributedString()
    let generator                   = QRCodeOutputViewController()
    var selectedLanguage            = UserDefaults.standard.string(forKey: "language") ?? "swift"
    let selectedTheme               = UserDefaults.standard.string(forKey: "theme") ?? "paraiso-dark"
    public var text:                String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup NavBar - title and NavBar button
        title = LocalizedStrings.scannedCodeTitle
        
        let saveButton              = UIBarButtonItem(title: LocalizedStrings.save,
                                                      style: .plain,
                                                      target: self,
                                                      action: #selector(assignAndSave))
        
        let changeLanguageButton    = UIBarButtonItem(title: LocalizedStrings.language,
                                                      style: .plain,
                                                      target: self,
                                                      action: #selector(changeLanguage))
        
        navigationItem.rightBarButtonItems = [saveButton, changeLanguageButton]
        
        // Setup ViewController
        setupView()
    }
}
