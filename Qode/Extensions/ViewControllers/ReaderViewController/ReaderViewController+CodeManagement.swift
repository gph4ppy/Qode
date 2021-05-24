//
//  ReaderViewController+CodeManagement.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 20/05/2021.
//

import UIKit

// MARK: - Code Management
extension ReaderViewController {
    /// This method returns the code from the QR code, which will be highlighted and assigned to TextView.
    /// - Returns: NSAttributedString which will be assigned to TextView
    func loadCode() -> NSAttributedString? {
        if let image = importedImage {
            text = getStringFromQRCode(from: image)
            return highlightr?.highlight(text ?? "", as: selectedLanguage)
        }
        
        return nil
    }
    
    /// This method returns the code (String) contained in the loaded QR code.
    /// - Parameter image: User-imported QR code
    /// - Returns: String contained in the QR code
    func getStringFromQRCode(from image: UIImage) -> String {
        var qrAsString = ""
        
        guard let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh]),
              let ciImage = CIImage(image: image),
              let features = detector.features(in: ciImage) as? [CIQRCodeFeature] else {
            return qrAsString
        }
        
        for feature in features {
            guard let indeedMessageString = feature.messageString else { continue }
            
            qrAsString += indeedMessageString
        }
        
        return qrAsString
    }
    
    /// This method assigns the qr code image and code content to the properties in this superclass.
    @objc internal func assignAndSave() {
        if let code = self.text {
            qrCode = generator.generateQRCode(from: code)
            codeContent = code
            saveCode()
        }
    }
}

