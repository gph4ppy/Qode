//
//  ScannerViewModel.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 08/06/2021.
//

import SwiftUI
import Combine
import AVFoundation

class ScannerViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var isGranted: Bool = false
    @Published var output = AVCapturePhotoOutput()
    @Published var imageData = Data(count: 0)
    @Published var window = NSWindow()
    @Published var didGenerateCode: Bool = false
    @Published var code: String = ""
    var captureSession: AVCaptureSession!
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        captureSession = AVCaptureSession()
        setupBindings()
    }
    
    func setupBindings() {
        $isGranted
            .sink { [weak self] isGranted in
                if isGranted {
                    self?.prepareCamera()
                } else {
                    self?.stopSession()
                }
            }
            .store(in: &cancellables)
    }
    
    func checkAuthorization() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            // The user has previously granted access to the camera.
            self.isGranted = true
        case .notDetermined:
            // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    DispatchQueue.main.async {
                        self?.isGranted = granted
                    }
                }
            }
        case .denied:
            // The user has previously denied access.
            self.isGranted = false
            return
        case .restricted:
            // The user can't grant access due to restrictions.
            self.isGranted = false
            return
        @unknown default:
            fatalError()
        }
    }
    
    func startSession() {
        guard !captureSession.isRunning else { return }
        captureSession.startRunning()
    }
    
    func stopSession() {
        guard captureSession.isRunning else { return }
        captureSession.stopRunning()
    }
    
    func prepareCamera() {
        captureSession.sessionPreset = .high
        
        if let device = AVCaptureDevice.default(for: .video) {
            startSessionForDevice(device)
        }
    }
    
    func startSessionForDevice(_ device: AVCaptureDevice) {
        DispatchQueue.main.async { [self] in
            do {
                let input = try AVCaptureDeviceInput(device: device)
                addInput(input)
                addOutput(output)
                startSession()
                ScannerViewModel.mirrorPreview()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func addInput(_ input: AVCaptureInput) {
        guard captureSession.canAddInput(input) == true else {
            return
        }
        
        captureSession.addInput(input)
    }
    
    func addOutput(_ output: AVCaptureOutput) {
        guard captureSession.canAddOutput(output) else {
            return
        }
        
        captureSession.addOutput(output)
    }
    
    func takePicture() {
        DispatchQueue.global(qos: .background).async {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        }
    }
    
    func retakePicture() {
        DispatchQueue.main.async {
            self.captureSession.startRunning()
            ScannerViewModel.mirrorPreview()
        }
    }
    
    static func mirrorPreview() {
        DispatchQueue.main.async {
            if let mirroringSupported = PlayerView.previewLayer?.connection?.isVideoMirroringSupported {
                if mirroringSupported {
                    PlayerView.previewLayer?.connection?.automaticallyAdjustsVideoMirroring = false
                    PlayerView.previewLayer?.connection?.isVideoMirrored = true
                }
            }
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil {
            print(error!.localizedDescription)
            return
        }
        
        guard let imageData = photo.fileDataRepresentation() else { return }
        self.imageData = imageData 
        self.didGenerateCode = true
        
        let nsImage = NSImage(data: imageData)
        self.code = QRCodeManager.getStringFromImage(image: nsImage)
        self.captureSession.stopRunning()
    }
}
