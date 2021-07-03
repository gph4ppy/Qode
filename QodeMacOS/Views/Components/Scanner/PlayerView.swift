//
//  PlayerView.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 08/06/2021.
//

import SwiftUI
import AVFoundation

class PlayerView: NSView {
    static var previewLayer: AVCaptureVideoPreviewLayer?
    
    init(captureSession: AVCaptureSession) {
        PlayerView.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        super.init(frame: .zero)
        
        setupLayer()
    }
    
    func setupLayer() {
        PlayerView.previewLayer?.frame = self.frame
        PlayerView.previewLayer?.contentsGravity = .resizeAspectFill
        PlayerView.previewLayer?.videoGravity = .resizeAspectFill
        
        ScannerViewModel.mirrorPreview()
        
        layer = PlayerView.previewLayer
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
