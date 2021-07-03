//
//  QRCodeView.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 14/06/2021.
//

import SwiftUI

struct QRCodeView: View {
    // Properties
    @State var nsImage: NSImage                 = NSImage(named: "Logo")!
    @State var showingSharingPicker: Bool       = false
    @State var didSaveCode: Bool                = false
    @State var pngData: Data                    = Data()
    @State var showingSavingAlert: Bool         = false
    @Binding var code: String
    
    var body: some View {
        ZStack {
            // View - NavBar and QR Code
            makeView()
                .padding()
                .onAppear(perform: prepareView)
                .savingAlert(showing: showingSavingAlert)
                .alert(isPresented: $didSaveCode) {
                    Alert(title: Text(LocalizedStrings.saved),
                          message: Text(LocalizedStrings.savedAlertBody),
                          dismissButton: .default(Text(LocalizedStrings.cool)))
                }
            
            // Saving Alert
            if showingSavingAlert {
                SavingAlert(didSaveCode: $didSaveCode,
                            pngData: $pngData,
                            code: $code,
                            showingSavingAlert: $showingSavingAlert)
            }
        }
    }
}
