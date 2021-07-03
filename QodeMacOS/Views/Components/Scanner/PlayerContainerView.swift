//
//  PlayerContainerView.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 08/06/2021.
//

import SwiftUI
import AVFoundation

final class PlayerContainerView: NSViewRepresentable {
    typealias NSViewType = PlayerView
    
    let captureSession: AVCaptureSession
    
    init(captureSession: AVCaptureSession) {
        self.captureSession = captureSession
    }
    
    func makeNSView(context: Context) -> PlayerView {
        return PlayerView(captureSession: captureSession)
    }
    
    func updateNSView(_ nsView: PlayerView, context: Context) {}
}
