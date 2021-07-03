//
//  SavedDetailViewController.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 21/05/2021.
//

import UIKit
import Highlightr

final class SavedDetailViewController: UIViewController, UITextViewDelegate {
    // Outlets
    @IBOutlet var qrCodeImageView:      UIImageView!
    @IBOutlet var codeView:             UIView!
    
    // Properties
    let highlightr                      = Highlightr()
    let textStorage                     = CodeAttributedString()
    let selectedTheme                   = UserDefaults.standard.string(forKey: "theme") ?? "paraiso-dark"
    var savedCode:                      DataToSave?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup View
        setupView()
        loadImage()
        
        // Setup title and NavBar Buttons
        title = savedCode?.title
        
        let shareButton = UIBarButtonItem(title: LocalizedStrings.share,
                                          style: .plain,
                                          target: self,
                                          action: #selector(shareCode))
        
        navigationItem.rightBarButtonItem = shareButton
    }
}
