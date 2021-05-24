//
//  ReaderViewController.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 20/05/2021.
//

import UIKit
import Highlightr

final class ReaderViewController: SavingManager, UIImagePickerControllerDelegate, UITextViewDelegate, UINavigationControllerDelegate {
    // Outlets
    @IBOutlet var qrCodeImageView:  UIImageView!
    @IBOutlet var codeView:         UIView!
    
    // Propertiesss
    internal let highlightr         = Highlightr()
    internal let textStorage        = CodeAttributedString()
    internal let picker             = UIImagePickerController()
    internal let generator          = QRCodeOutputViewController()
    internal var selectedLanguage   = UserDefaults.standard.string(forKey: "language") ?? "swift"
    internal let selectedTheme      = UserDefaults.standard.string(forKey: "theme") ?? "paraiso-dark"
    internal var importedImage:     UIImage?
    internal var text:              String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup NavBar Buttons
        let importButton            = UIBarButtonItem(barButtonSystemItem: .add,
                                                      target: self,
                                                      action: #selector(importQRCode))
        
        let selectLanguageButton    = UIBarButtonItem(title: LocalizedStrings.language,
                                                      style: .plain,
                                                      target: self,
                                                      action: #selector(changeLanguage))
        
        let saveButton              = UIBarButtonItem(title: LocalizedStrings.save,
                                                      style: .plain,
                                                      target: self,
                                                      action: #selector(assignAndSave))
        
        navigationItem.rightBarButtonItems = [importButton, selectLanguageButton, saveButton]
    }
    
    // When the user imported a photo with a QR code, assign a QR code image to the ImageView and programming code to the TextView.
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        DispatchQueue.main.async { [self] in
            guard let image = info[.originalImage] as? UIImage else { return }
            
            importedImage = image
            qrCodeImageView.image = importedImage
            
            setupView()
            
            dismiss(animated: true)
        }
    }
}
