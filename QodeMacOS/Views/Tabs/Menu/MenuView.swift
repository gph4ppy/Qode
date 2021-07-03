//
//  MenuView.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 20/05/2021.
//

import SwiftUI

struct MenuView: View {
    // Properties
    @ObservedObject var menuVM: MenuViewModel      = MenuViewModel()
    let size: CGRect                               = NSScreen.main!.frame
    let year: Int                                  = Calendar.current.component(.year, from: Date())
    
    var body: some View {
        NavigationView {
            // MARK: Side Menu
            makeSideBar()
            
            // MARK: Main Window View
            switch menuVM.selectedMenuTab {
                case MainMenuTab.generator.data.title:
                    GeneratorView()
                case MainMenuTab.scanner.data.title:
                    ScannerView()
                case MainMenuTab.reader.data.title:
                    ReaderView()
                case MainMenuTab.saved.data.title:
                    SavedView()
                default:
                    StartView()
            }
        }
        .frame(minWidth: 800,
               maxWidth: .infinity,
               minHeight: 600,
               maxHeight: .infinity)
    }
}

