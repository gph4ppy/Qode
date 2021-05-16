//
//  ScannerViewController+VideoRotation.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 01/05/2021.
//

import UIKit
import AVFoundation

// MARK: - Video Rotation
extension ScannerViewController {
    // This method detects when the screen is rotated.
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        performSelector(onMainThread: #selector(setupVideoPreviewRotation), with: nil, waitUntilDone: false)
    }
    
    /// This method adjusts the display of the video preview based on the screen orientation.
    @objc func setupVideoPreviewRotation() {
        if let previewLayerConnection: AVCaptureConnection = video.connection {
            if previewLayerConnection.isVideoOrientationSupported {
                let deviceOrientation = UIDevice.current.orientation
                
                switch deviceOrientation {
                    case .portrait:
                        previewLayerConnection.videoOrientation = .portrait
                        reloadVideoPreview()
                    case .landscapeLeft:
                        previewLayerConnection.videoOrientation = .landscapeRight
                        reloadVideoPreview()
                    case .landscapeRight:
                        previewLayerConnection.videoOrientation = .landscapeLeft
                        reloadVideoPreview()
                    default:
                        print("This orientation is not supported")
                        previewLayerConnection.videoOrientation = .portrait
                        reloadVideoPreview()
                }
            }
        }
    }
    
    /// This method reloads the video frame and dark overlay.
    private func reloadVideoPreview() {
        video.frame = view.layer.bounds
        darkOverlay.removeFromSuperview()
        setScannableArea()
    }
}
