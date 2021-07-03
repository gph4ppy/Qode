//
//  LanguageActionSheet.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 12/06/2021.
//

import SwiftUI

struct LanguageActionSheet: View {
    @AppStorage("language") var selectedLanguage = "swift"
    @State private var searchText = ""
    let allLanguages = TextView.highlightr!.supportedLanguages()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Text(LocalizedStrings.languageTitle)
                .font(.largeTitle)
            
            Text(LocalizedStrings.languageBody)
                .multilineTextAlignment(.center)
            
            SearchBar(text: $searchText)
            
            ForEach(allLanguages.filter({
                searchText.isEmpty ? true : $0.contains(searchText.lowercased())
            }), id: \.self) { language in
                Button(action: { self.selectedLanguage = language }) {
                    Text(language)
                        .foregroundColor(Color.primary)
                        .frame(width: 380)
                        .padding(2)
                        .background(
                            Color(NSColor.windowBackgroundColor)
                                .clipShape(Capsule())
                        )
                        .overlay(
                            Capsule()
                                .stroke(Color.primary)
                        )
                }
            }
        }
        .padding()
        .buttonStyle(PlainButtonStyle())
    }
}
