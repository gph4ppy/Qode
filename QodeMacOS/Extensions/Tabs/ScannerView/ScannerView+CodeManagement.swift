//
//  ScannerView+CodeManagement.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 25/06/2021.
//

import SwiftUI

// MARK: - Code Management
extension ScannerView {
    func getPngData(from nsImage: NSImage) -> Data {
        // Get image png data
        guard let data = nsImage.tiffRepresentation else { return Data() }
        let imageRep = NSBitmapImageRep(data: data)
        
        if let pngData = imageRep?.representation(using: .png, properties: [:]) {
            // Assign png data and reset the variable responsible for the detection of the code if has been saved.
            return pngData
        }
        
        return Data()
    }
}
