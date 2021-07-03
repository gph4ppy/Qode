//
//  SavedCodeCard.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 15/06/2021.
//

import SwiftUI

struct SavedCodeCard: View {
    // Properties
    @State var savedCode: SavedCode
    @AppStorage("darkMode") var darkMode = "System"
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: SavedCode.entity(), sortDescriptors: [])
    var codes: FetchedResults<SavedCode>
    @Binding var isEditing: Bool
    @State private var nsImage: NSImage = NSImage(systemSymbolName: "qrcode",
                                                  accessibilityDescription: nil)!
    @State private var tapped: Bool = false
    
    var body: some View {
        HStack(spacing: 15) {
            Image(nsImage: nsImage)
                .resizable()
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(savedCode.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                
                Text(savedCode.language)
                    .font(.caption2)
                
                if let date = savedCode.date {
                    Text(DataManager.dateFormatter.string(from: date))
                        .font(.footnote)
                }
            }
            .frame(height: 50)
            
            Spacer()
            
            if isEditing {
                Button(action: delete) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            } else {
                Image(systemName: "chevron.forward")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .onAppear {
            if let nsImage = NSImage(data: savedCode.qrCode) {
                self.nsImage = nsImage
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                self.tapped = true
            }
            
            DetailView(savedCode: $savedCode)
                .frame(width: 720, height: NSScreen.main!.frame.height / 2)
                .preferredColorScheme(darkMode == "System" ? colorScheme : (darkMode == "On" ? .dark : .light))
                .openInWindow(title: LocalizedStrings.yourSavedCode, sender: self)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(350)) {
                withAnimation {
                    self.tapped = false
                }
            }
        }
        .overlay(Color.gray.opacity(self.tapped ? 0.3 : 0))
    }
    
    /// This function removes the selected loved color.
    /// - Parameter index: A selected position, which is about to be removed.
    func delete() {
        viewContext.delete(savedCode)
    }
}
