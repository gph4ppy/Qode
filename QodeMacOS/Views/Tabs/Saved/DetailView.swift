//
//  DetailView.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 17/06/2021.
//

import SwiftUI

struct DetailView: View {
    // Properties
    @State private var image: Image = Image(systemName: "qrcode")
    @Binding var savedCode: SavedCode
    
    var body: some View {
        VStack {
            // Title
            Text(savedCode.title)
                .font(.system(size: 25, weight: .bold, design: .default))
            
            // QR Code
            image
                .resizable()
                .frame(width: 150, height: 150)
                .shadow(radius: 5)
                .padding([.leading, .bottom, .trailing])
            
            // Code Text View
            TextView(code: $savedCode.code, isEditable: false)
        }
        .padding()
        .onAppear {
            if let nsImage = NSImage(data: savedCode.qrCode) {
                self.image = Image(nsImage: nsImage)
            }
        }
    }
}
