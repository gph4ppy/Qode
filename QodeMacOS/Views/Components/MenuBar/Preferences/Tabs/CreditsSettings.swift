//
//  CreditsSettings.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 02/07/2021.
//

import SwiftUI

struct CreditsSettings: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            Text(LocalizedStrings.creditsBody + ": Highlightr")
                .fontWeight(.semibold)
                .padding(.bottom)
            
            Text(LocalizedStrings.highlightrBody)
        }
    }
}

struct CreditsSettings_Previews: PreviewProvider {
    static var previews: some View {
        CreditsSettings()
    }
}
