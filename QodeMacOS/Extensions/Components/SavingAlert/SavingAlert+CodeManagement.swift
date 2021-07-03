//
//  SavingAlert+CodeManagement.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 27/06/2021.
//

import SwiftUI

// MARK: - Code Management
extension SavingAlert {
    /// This method saves the QR Code into the device memory.
    /// - Parameter data: A model which contains data that will be saved
    func saveQRCode(data: DataToSave) {
        let newCode = SavedCode(context: viewContext)
        
        newCode.title = data.title
        newCode.code = data.code
        newCode.qrCode = data.qrCode
        newCode.language = data.language
        newCode.date = data.date
        newCode.id = UUID()
        
        PersistenceController.shared.saveContext()
        
        self.didSaveCode = true
        withAnimation { self.showingSavingAlert = false }
    }
}
