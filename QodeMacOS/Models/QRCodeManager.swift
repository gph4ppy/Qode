//
//  QRCodeManager.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 24/06/2021.
//

import SwiftUI

struct QRCodeManager {
    /// This method generates a QR code that can then be scanned or shared.
    /// - Parameter string: Code from which the QR code will be generated
    /// - Returns: Optional UIImage (QR code)
    static func generateQRCode(from string: String) -> NSImage? {
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        let data = Data(string.utf8)
        let context = CIContext()
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        
        filter.setValue(data, forKey: "inputMessage")
        
        if let qrCodeImage = filter.outputImage?.transformed(by: transform) {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                return NSImage(cgImage: qrCodeCGImage, size: NSSize(width: 500, height: 500))
            }
        }
        
        return nil
    }
    
    /// This method returns the code (String) contained in the loaded QR code.
    /// - Parameter image: User-imported QR code
    /// - Returns: String contained in the QR code
    static func getStringFromImage(image: NSImage?) -> String {
        var qrAsString = ""
        
        guard let data = image?.tiffRepresentation else { return "⚠️" }
        let imageRep = NSBitmapImageRep(data: data)
        
        if let pngData = imageRep?.representation(using: .png, properties: [:]) {
            guard let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh]),
                  let ciImage = CIImage(data: pngData),
                  let features = detector.features(in: ciImage) as? [CIQRCodeFeature] else {
                      return qrAsString
                  }
            
            for feature in features {
                guard let indeedMessageString = feature.messageString else { continue }
                
                qrAsString += indeedMessageString
            }
        }
        
        return qrAsString
    }
}
