//
//  ReaderView.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 23/06/2021.
//

import SwiftUI

struct ReaderView: View {
    // Properties
    @State var nsImage: NSImage?
    @State var code: String?
    
    var body: some View {
        VStack {
            // NavBar
            navBar
                .navBarModifier()
            
            // View - QR code and programming code
            makeView()
            
            Spacer()
        }
    }
}
