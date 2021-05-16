//
//  ScannedCodeViewController.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 21/04/2021.
//

import UIKit
import Highlightr

final class ScannedCodeViewController: UIViewController {
    // Outlets
    @IBOutlet var paddingView:      UIView!
    
    // Properties
    internal let highlightr         = Highlightr()
    internal let textStorage        = CodeAttributedString()
    internal var selectedLanguage   = UserDefaults.standard.string(forKey: "language") ?? "swift"
    internal let selectedTheme      = UserDefaults.standard.string(forKey: "theme") ?? "paraiso-dark"
    public var text:                String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup NavBar - title and NavBar button
        title = LocalizedStrings.scannedCodeTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: LocalizedStrings.language,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(changeLanguage))
        
        // Setup ViewController
        setupView()
    }
}
