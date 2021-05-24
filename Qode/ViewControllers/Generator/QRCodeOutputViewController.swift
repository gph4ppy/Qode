//
//  QRCodeOutputViewController.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 24/04/2021.
//

import UIKit
import CoreImage
import CoreData

final class QRCodeOutputViewController: SavingManager {
    // Outlets
    @IBOutlet var codeImageView:    UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup NavBar - title and NavBar button
        title = LocalizedStrings.codeOutputTitle
        
        let saveButton = UIBarButtonItem(title: LocalizedStrings.save,
                                         style: .plain,
                                         target: self,
                                         action: #selector(saveCode))
        
        let shareButton = UIBarButtonItem(title: LocalizedStrings.share,
                                          style: .plain,
                                          target: self,
                                          action: #selector(shareCode))
        
        navigationItem.rightBarButtonItems = [shareButton, saveButton]
        
        // Assign the QR code to the image view
        DispatchQueue.main.async {
            if let unwrappedCode = self.code {
                if let image = self.generateQRCode(from: unwrappedCode) {
                    self.codeImageView.image = image
                    self.qrCode = image
                    self.codeContent = unwrappedCode
                }
            }
        }
    }
}
