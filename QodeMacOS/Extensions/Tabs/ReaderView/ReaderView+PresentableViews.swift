//
//  ReaderView+PresentableViews.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 25/06/2021.
//

import SwiftUI

// MARK: - Presentable Views
extension ReaderView {
    @ViewBuilder func makeView() -> some View {
        if let nsImage = nsImage,
           let code = code {
            Image(nsImage: nsImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 225)
                .padding()
            
            TextView(code: .constant(code), isEditable: false)
        }
    }
    
    @ViewBuilder var navBar: some View {
        ZStack {
            Text(LocalizedStrings.readCode)
                .font(.system(size: 25, weight: .bold, design: .default))
            
            HStack {
                Spacer()
                
                Button(action: importImage) {
                    Text(LocalizedStrings.importButton)
                }
                
                Button(action: importImage) {
                    Text(LocalizedStrings.generate)
                }
            }
            .padding(.leading, 30)
        }
    }
}
