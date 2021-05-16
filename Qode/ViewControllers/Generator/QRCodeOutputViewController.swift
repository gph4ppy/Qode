//
//  QRCodeOutputViewController.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 24/04/2021.
//

import UIKit
import CoreImage

final class QRCodeOutputViewController: UIViewController {
    // Outlets
    @IBOutlet var codeImageView:    UIImageView!
    
    // Properties
    internal var code:              String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup NavBar - title and NavBar button
        title = LocalizedStrings.codeOutputTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: LocalizedStrings.share,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(shareCode))
        
        // Assign the QR code to the image view
        DispatchQueue.main.async {
            if let unwrappedCode = self.code {
                if let image = self.generateQRCode(from: unwrappedCode) {
                    self.codeImageView.image = image
                }
            }
        }
    }
}
