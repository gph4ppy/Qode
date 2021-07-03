//
//  ReaderView+CodeManagement.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 25/06/2021.
//

import SwiftUI

// MARK: - QR Code Management
extension ReaderView {
    func importImage() {
        // Setup Panel
        let imagePicker = NSOpenPanel()
        imagePicker.prompt = LocalizedStrings.selectImage
        imagePicker.worksWhenModal = true
        imagePicker.canChooseFiles = true
        imagePicker.canChooseDirectories = false
        imagePicker.allowedFileTypes = ["png", "jpg", "jpeg"]
        imagePicker.allowsMultipleSelection = false
        
        // Get the image from returned path
        imagePicker.begin { (result) -> Void in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                guard let selectedPath = imagePicker.url?.path else { return }
                let url = URL(fileURLWithPath: selectedPath)
                
                if let image = NSImage(contentsOf: url) {
                    self.nsImage = image
                    self.code = QRCodeManager.getStringFromImage(image: nsImage)
                }
            }
        }
    }
}
