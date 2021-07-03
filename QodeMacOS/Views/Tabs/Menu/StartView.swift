//
//  StartView.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 01/06/2021.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        HStack {
            Image(systemName: "arrow.backward")
            Image(systemName: "cursorarrow.rays")
            Text(LocalizedStrings.welcomeTitle)
        }
        .font(.subheadline)
        .foregroundColor(.gray)
    }
}
