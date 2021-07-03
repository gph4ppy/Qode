//
//  AboutSettings.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 02/07/2021.
//

import SwiftUI

struct AboutSettings: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 125)
            
            Text(LocalizedStrings.aboutQode)
                .fontWeight(.semibold)
            Text(LocalizedStrings.aboutQodeBody)
                .multilineTextAlignment(.center)
        }
    }
}

struct AboutSettings_Previews: PreviewProvider {
    static var previews: some View {
        AboutSettings()
    }
}
