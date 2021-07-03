//
//  QRCodeOutputViewController+QRCodeManagement.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 02/05/2021.
//

import UIKit
import CoreImage.CIFilterBuiltins

// MARK: - QR Code Management
extension QRCodeOutputViewController {
    /// This opens up the UIActivityViewController which allows sharing the QR code.
    @objc func shareCode() {
        let child = SpinnerViewController()
        
        // Add the Spinner View Controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        // Initialize UIActivityViewController
        DispatchQueue.global(qos: .userInteractive).async {
            if let code = self.code {
                if let image = self.generateQRCode(from: code) {
                    let items = [image]
                    let ac = UIActivityViewController(activityItems: items, applicationActivities: [])
                    
                    // Stop ActivityIndicator and show UIActivityViewController
                    DispatchQueue.main.async {
                        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
                        self.present(ac, animated: true)
                        
                        child.willMove(toParent: nil)
                        child.view.removeFromSuperview()
                        child.removeFromParent()
                    }
                }
            }
        }
    }
    
    /// This method generates a QR code that can then be scanned or shared.
    /// - Parameter string: Code from which the QR code will be generated
    /// - Returns: Optional UIImage (QR code)
    func generateQRCode(from string: String) -> UIImage? {
        let data = Data(string.utf8)
        let filter = CIFilter.qrCodeGenerator()
        let context = CIContext()
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        
        filter.setValue(data, forKey: "inputMessage")
        
        if let qrCodeImage = filter.outputImage?.transformed(by: transform) {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
        
        return nil
    }
}
