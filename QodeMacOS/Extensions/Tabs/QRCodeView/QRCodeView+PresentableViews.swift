//
//  QRCodeView+PresentableViews.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 24/06/2021.
//

import SwiftUI

// MARK: - Presentable Views
extension QRCodeView {
    // View
    @ViewBuilder func makeView() -> some View {
        VStack {
            // Buttons
            HStack {
                saveButton
                Spacer()
                shareButton
            }
            .buttonStyle(PlainButtonStyle())
            
            // QR Code
            Image(nsImage: nsImage)
                .resizable()
                .aspectRatio(nil, contentMode: .fit)
        }
    }
    
    // Save Button
    @ViewBuilder var saveButton: some View {
        Button(LocalizedStrings.save) {
            withAnimation {
                self.showingSavingAlert = true
            }
        }
        .padding(.leading, 10)
    }
    
    // Share Button
    @ViewBuilder var shareButton: some View {
        Button(LocalizedStrings.share) {
            self.showingSharingPicker = true
        }
        .padding(.trailing, 10)
        .background(
            SharingsPicker(isPresented: $showingSharingPicker,
                           sharingItems: [nsImage, code])
        )
    }
}
