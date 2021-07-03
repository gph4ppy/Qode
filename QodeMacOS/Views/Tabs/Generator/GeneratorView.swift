//
//  GeneratorView.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 01/06/2021.
//

import SwiftUI

struct GeneratorView: View {
    // Properties
    @State var showingErrorAlert: Bool                              = false
    @State var code: String                                         = ""
    @AppStorage("language") private var selectedLanguage: String    = "swift"
    @AppStorage("darkMode") var darkMode                            = "System"
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var viewContext
    
    // Alert Properties
    @State var title: String                                        = ""
    @State var message: String                                      = ""
    @State var action: String                                       = ""
    
    var body: some View {
        VStack {
            // Create NavBar
            makeNavBar()
            
            // Add TextView
            GeometryReader { geom in
                TextView(code: $code, startSize: geom.size)
            }
        }
        .alert(isPresented: $showingErrorAlert) {
            Alert(title: Text(self.title),
                  message: Text(self.message),
                  dismissButton: .default(Text(self.action))
            )
        }
    }
}
