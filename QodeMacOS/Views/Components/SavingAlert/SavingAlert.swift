//
//  SavingAlert.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 15/06/2021.
//

import SwiftUI

struct SavingAlert: View {
    // Properties
    @State var title: String                   = LocalizedStrings.title
    @State var selectedLanguage: String        = "swift"
    @State var didSelectLanguage: Bool         = false
    @State var dataToSave: DataToSave?
    @Binding var didSaveCode: Bool
    @Binding var pngData: Data
    @Binding var code: String
    @Binding var showingSavingAlert: Bool
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        VStack {
            // Title
            Text(LocalizedStrings.savingPanel)
                .font(.largeTitle)
                .padding(.top)
            
            VStack(alignment: .leading) {
                // Form
                savingForm
                
                // Buttons
                buttons
                .padding(.top)
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}
