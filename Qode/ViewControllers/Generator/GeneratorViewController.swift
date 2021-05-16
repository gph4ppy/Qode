//
//  GeneratorViewController.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 23/04/2021.
//

import UIKit
import Highlightr

final class GeneratorViewController: UIViewController, UITextViewDelegate, AlertPresenter {
    // Outlets
    @IBOutlet var paddingView:      UIView!
    
    // Properties
    internal let highlightr         = Highlightr()
    internal let textStorage        = CodeAttributedString()
    internal var selectedLanguage   = UserDefaults.standard.string(forKey: "language") ?? "swift"
    internal let selectedTheme      = UserDefaults.standard.string(forKey: "theme") ?? "paraiso-dark"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup ViewController
        setupView()
        
        // Setup NavBar Buttons
        let generateButton          = UIBarButtonItem(title: LocalizedStrings.generate,
                                                      style: .plain,
                                                      target: self,
                                                      action: #selector(generateQRCode))
        
        let selectLanguageButton    = UIBarButtonItem(title: LocalizedStrings.language,
                                                      style: .plain,
                                                      target: self,
                                                      action: #selector(changeLanguage))
        
        navigationItem.rightBarButtonItems = [generateButton, selectLanguageButton]
    }
}
