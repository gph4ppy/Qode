//
//  ScannerView+PresentableViews.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 25/06/2021.
//

import SwiftUI

// MARK: - Presentable Views
extension ScannerView {
    // Scanner and NavBar
    @ViewBuilder var scannerView: some View {
        Text(LocalizedStrings.scanCode)
            .font(.system(size: 25, weight: .bold, design: .default))
            .padding([.top, .leading, .trailing])
        PlayerContainerView(captureSession: viewModel.captureSession)
            .overlay(
                ZStack {
                    ScanOverlayView()
                    cameraButton
                }
            )
    }
    
    // Camera Button
    @ViewBuilder var cameraButton: some View {
        VStack {
            Spacer()
            
            Button(action: viewModel.takePicture) {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: shotButtonSize,
                               height: shotButtonSize)
                    
                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                        .frame(width: shotButtonSize + 10,
                               height: shotButtonSize + 10)
                        .overlay(
                            Image(systemName: "camera")
                                .foregroundColor(.black)
                                .font(.system(size: 14))
                        )
                }
            }
        }
        .padding(.bottom, 10)
        .buttonStyle(PlainButtonStyle())
    }
    
    // Scanned Code View
    @ViewBuilder var scannedCode: some View {
        ZStack {
            VStack {
                ZStack {
                    Text(LocalizedStrings.scannedCode)
                        .font(.system(size: 25, weight: .bold, design: .default))
                    
                    HStack(spacing: 10) {
                        Spacer()
                        
                        Button(LocalizedStrings.language) {
                            LanguageActionSheet()
                                .frame(width: 400, height: 600)
                                .preferredColorScheme(darkMode == "System" ? colorScheme : (darkMode == "On" ? .dark : .light))
                                .openInWindow(title: LocalizedStrings.languageTitle, sender: self)
                        }
                        
                        Button(LocalizedStrings.save) {
                            if let nsImage = QRCodeManager.generateQRCode(from: self.code) {
                                ScannerView.pngData = getPngData(from: nsImage)
                                withAnimation { self.showingSavingAlert = true }
                            }
                        }
                    }
                }
                .navBarModifier()
                
                TextView(code: $code, isEditable: false)
            }
            .savingAlert(showing: showingSavingAlert)
            
            // Saving Alert
            if let pngData = ScannerView.pngData {
                if showingSavingAlert {
                    SavingAlert(didSaveCode: $didSaveCode,
                                pngData: .constant(pngData),
                                code: $code,
                                showingSavingAlert: $showingSavingAlert)
                    
                }
            }
        }
    }
    
    // Error View
    @ViewBuilder var errorMessage: some View {
        Text(LocalizedStrings.scanErrorTitle)
            .font(.system(size: 25, weight: .bold, design: .default))
        Text(LocalizedStrings.scanErrorBody)
            .font(.footnote)
            .foregroundColor(.gray)
            .padding([.leading, .bottom, .trailing], 40)
            .padding(.top, 2)
        
        Button(action: {
            viewModel.retakePicture()
            viewModel.didGenerateCode = false
        }) {
            Text(LocalizedStrings.retakePicture)
        }
    }
}
