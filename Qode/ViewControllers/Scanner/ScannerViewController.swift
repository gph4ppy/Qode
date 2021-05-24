//
//  ScannerViewController.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 18/04/2021.
//

import UIKit
import AVFoundation

final class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    // Outlets
    @IBOutlet var scannerAreaSquare:                 UIView!
    
    // Properties
    internal var video: AVCaptureVideoPreviewLayer   = AVCaptureVideoPreviewLayer()
    internal let session: AVCaptureSession           = AVCaptureSession()
    internal var darkOverlay: UIView!                = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup View - title and scanner
        title = LocalizedStrings.scannerTitle
        setupScanner()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Setup scannable area (square)
        setScannableArea()
        
        // Setup video preview rotation
        setupVideoPreviewRotation()
        
        // Start session
        self.session.startRunning()
        
        // Change NavBar Title Color to white
        changeNavBarTitleColor(to: .white)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Change NavBar Title Color to the default color
        changeNavBarTitleColor(to: .label)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Remove dark overlay when view disappears
        darkOverlay.removeFromSuperview()
    }
    
    // When a QR code is detected, show its text content in ScannedCodeViewController.
    internal func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            if object.type == AVMetadataObject.ObjectType.qr {
                if let vc = storyboard?.instantiateViewController(identifier: "scannedCodeVC") as? ScannedCodeViewController {
                    vc.text = object.stringValue
                    self.navigationController?.pushViewController(vc, animated: true)
                    AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                    session.stopRunning()
                }
            }
        }
    }
}
