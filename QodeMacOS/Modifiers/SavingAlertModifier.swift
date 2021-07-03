//
//  SavingAlertModifier.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 25/06/2021.
//

import SwiftUI

struct SavingAlertModifier: ViewModifier {
    // Properties
    let showingSavingAlert: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay(showingSavingAlert ? Color.black.opacity(0.7) : nil)
            .blur(radius: showingSavingAlert ? 10 : 0)
    }
}
