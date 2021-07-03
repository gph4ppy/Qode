//
//  View+ViewModiifiers.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 24/06/2021.
//

import SwiftUI

extension View {
    func navBarModifier() -> some View {
        self.modifier(NavBarModifier())
    }
    
    func savingAlert(showing: Bool) -> some View {
        self.modifier(SavingAlertModifier(showingSavingAlert: showing))
    }
}
