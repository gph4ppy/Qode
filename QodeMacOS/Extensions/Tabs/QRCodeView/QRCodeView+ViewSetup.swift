//
//  QRCodeView+ViewSetup.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 24/06/2021.
//

import SwiftUI

// MARK: - View Setup
extension QRCodeView {
    func prepareView() {
        if let nsImage = QRCodeManager.generateQRCode(from: code) {
            self.nsImage = nsImage
            
            // Get image png data
            guard let data = nsImage.tiffRepresentation else { return }
            let imageRep = NSBitmapImageRep(data: data)
            
            if let pngData = imageRep?.representation(using: .png, properties: [:]) {
                // Assign png data and reset the variable responsible for the detection of the code if has been saved.
                self.pngData = pngData
                self.didSaveCode = false
            }
        }
    }
}
