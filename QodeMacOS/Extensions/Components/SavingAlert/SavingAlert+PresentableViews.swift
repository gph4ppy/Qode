//
//  SavingAlert+PresentableViews.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 27/06/2021.
//

import SwiftUI

// MARK: - Presentable Views
extension SavingAlert {
    // Form
    @ViewBuilder var savingForm: some View {
        Text(LocalizedStrings.savingDescription1)
        TextField(title, text: $title)
            .textFieldStyle(.roundedBorder)
            .foregroundColor(.primary)
        
        Spacer()
            .frame(height: 30)
        
        Text(LocalizedStrings.savingDescription2)
        Menu(didSelectLanguage ? selectedLanguage : LocalizedStrings.selectLanguage) {
            ForEach(TextView.highlightr!.supportedLanguages(), id: \.self) { language in
                Button(action: {
                    self.selectedLanguage = language
                    self.didSelectLanguage = true
                }) {
                    Text(language)
                }
            }
        }
    }
    
    // Buttons
    @ViewBuilder var buttons: some View {
        HStack(spacing: 10) {
            Spacer()
            
            Button(LocalizedStrings.cancel) {
                withAnimation {
                    self.showingSavingAlert = false
                }
            }
            
            Button(LocalizedStrings.save) {
                self.dataToSave = DataToSave(title: self.title,
                                             code: self.code,
                                             qrCode: self.pngData,
                                             language: self.selectedLanguage,
                                             date: Date())
                
                if let dataToSave = dataToSave {
                    saveQRCode(data: dataToSave)
                }
            }
        }
    }
}
