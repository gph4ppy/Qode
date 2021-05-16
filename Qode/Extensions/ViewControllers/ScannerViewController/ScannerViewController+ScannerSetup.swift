//
//  ScannerViewController+ScannerSetup.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 01/05/2021.
//

import UIKit
import AVFoundation

// MARK: - Scanner Setup
extension ScannerViewController {
    /// This method setups the scanner view
    internal func setupScanner() {
        // Define device
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        // Setup input
        do {
            let input = try AVCaptureDeviceInput(device: device)
            self.session.addInput(input)
        } catch {
            print(error.localizedDescription)
        }
        
        // Setup output
        let output = AVCaptureMetadataOutput()
        self.session.addOutput(output)
        
        // Set Type of detected objects - QR Codes
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [.qr]
        output.rectOfInterest = video.metadataOutputRectConverted(fromLayerRect: scannerAreaSquare.bounds)

        // Setup video and its frame
        video = AVCaptureVideoPreviewLayer(session: self.session)
        video.frame = view.layer.bounds
        video.videoGravity = .resizeAspectFill
        view.layer.addSublayer(video)
    }
    
    /// This method setups the scannable rectangle area
    internal func setScannableArea() {
        let scannerAreaColor = UserDefaults.standard.colorForKey(key: "scannerColor") ?? .systemYellow
            
        // Add Rectangle
        scannerAreaSquare.layer.borderWidth = 3
        scannerAreaSquare.layer.cornerRadius = Styling.cornerRadius
        scannerAreaSquare.layer.borderColor = scannerAreaColor.cgColor
        view.bringSubviewToFront(scannerAreaSquare)
        
        // Setup overlay
        darkOverlay = UIView(frame: view.bounds)
        darkOverlay.backgroundColor = .black
        darkOverlay.alpha = 0.55
        view.addSubview(darkOverlay)
        
        // Set size
        let size = view.bounds
        let width = scannerAreaSquare.frame.width
        let height = scannerAreaSquare.frame.height
        let x = (size.width / 2) - (width / 2)
        let y = (size.height / 2) - (height / 2)
        
        // Setup mask
        let scannerAreaMask = CGRect(x: x, y: y, width: width, height: height)
        Styling.setMask(with: scannerAreaMask, in: darkOverlay)
    }
}

