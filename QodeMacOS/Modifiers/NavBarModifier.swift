//
//  NavBarModifier.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 24/06/2021.
//

import SwiftUI

struct NavBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(PlainButtonStyle())
            .padding([.top, .leading, .trailing])
    }
}
