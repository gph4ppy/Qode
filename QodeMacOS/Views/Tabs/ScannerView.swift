//
//  ScannerView.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 05/06/2021.
//

import SwiftUI
import AVFoundation

struct ScannerView: View {
    // Properties
    @State var code: String                                     = ""
    @State var showingSavingAlert: Bool                         = false
    @State var didSaveCode: Bool                                = false
    @ObservedObject var viewModel: ScannerViewModel             = ScannerViewModel()
    @AppStorage("language") private var selectedLanguage        = "swift"
    @AppStorage("darkMode") var darkMode                        = "System"
    @Environment(\.colorScheme) var colorScheme
    let shotButtonSize: CGFloat                                 = 30
    static public var pngData: Data?
    
    init() {
        viewModel.checkAuthorization()
    }
    
    var body: some View {
        VStack {
            if viewModel.didGenerateCode {
                if self.code.isEmpty {
                    errorMessage
                } else {
                    scannedCode
                        .alert(isPresented: $didSaveCode) {
                            Alert(title: Text(LocalizedStrings.saved),
                                  message: Text(LocalizedStrings.savedAlertBody),
                                  dismissButton: .default(Text(LocalizedStrings.cool)))
                        }
                }
            } else {
                scannerView
            }
        }
        .onAppear { viewModel.didGenerateCode = false }
        .onChange(of: viewModel.didGenerateCode) { _ in
            self.code = viewModel.code
        }
    }
}
