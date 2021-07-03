//
//  TextView.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 05/06/2021.
//

import SwiftUI
import AppKit
import Highlightr

/// A wrapper around NSTextView
struct TextView: NSViewRepresentable {
    // Properties
    @Binding private var code: String
    @Environment(\.undoManager) private var undoManager
    @AppStorage("language") var selectedLanguage = "swift"
    @AppStorage("theme") var selectedTheme = "paraiso-dark"
    static let highlightr = Highlightr()
    static let textStorage = CodeAttributedString()
    static let textViewFrame: CGRect = .zero
    static let textContainer = NSTextContainer(size: CGSize(width: textStorage.size().width + 30,
                                                            height: textStorage.size().height))
    static let text = NSTextView(frame: textViewFrame, textContainer: textContainer)
    private let isEditable: Bool
    private let startSize: CGSize
    
    init(code: Binding<String>, isEditable: Bool = true, startSize: CGSize = CGSize(width: 200, height: 200)) {
        _code = code
        self.isEditable = isEditable
        self.startSize = startSize
    }
    
    init(code: String) {
        self.init(code: Binding<String>.constant(code),
                  isEditable: false,
                  startSize: CGSize(width: 200, height: 200))
    }
    
    func makeNSView(context: Context) -> NSScrollView {
        // Set theme
        TextView.highlightr?.setTheme(to: selectedTheme)
        
        // Create layout manager
        let layoutManager = NSLayoutManager()
        TextView.textStorage.addLayoutManager(layoutManager)
        
        // Create text container
        layoutManager.addTextContainer(TextView.textContainer)
        TextView.textContainer.widthTracksTextView = true
        TextView.textContainer.heightTracksTextView = true
        
        TextView.text.backgroundColor = isEditable ? .textBackgroundColor : .clear
        TextView.text.delegate = context.coordinator
        TextView.text.isRichText = false
        TextView.text.autoresizingMask = [.width, .height]
        TextView.text.translatesAutoresizingMaskIntoConstraints = false
        TextView.text.isVerticallyResizable = true
        TextView.text.isHorizontallyResizable = false
        TextView.text.isEditable = isEditable
        TextView.text.allowsUndo = true
        
        // MARK: SIZE
        if !code.isEmpty {
            let size = TextView.textStorage.size()
            TextView.text.frame.size = CGSize(width: size.width + 30, height: size.height)
        } else {
            TextView.text.frame.size = startSize
        }
        
        let scroll = NSScrollView()
        scroll.hasVerticalScroller = true
        scroll.documentView = TextView.text
        scroll.drawsBackground = false
        
        return scroll
    }
    
    func updateNSView(_ view: NSScrollView, context: Context) {
        DispatchQueue.main.async {
            let text = view.documentView as? NSTextView
            text?.string = self.code
            
            if let attributedString = setupLanguage() {
                text?.textStorage?.setAttributedString(attributedString)
            }
            
            guard context.coordinator.selectedRanges.count > 0 else {
                return
            }
            
            text?.selectedRanges = context.coordinator.selectedRanges
            
            
            if !TextView.textStorage.string.isEmpty {
                let size = TextView.textStorage.size()
                TextView.text.frame.size = CGSize(width: size.width + 30, height: size.height)
            } else {
                TextView.text.frame.size = TextView.textStorage.size()
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: TextView
        var selectedRanges = [NSValue]()
        
        init(_ parent: TextView) {
            self.parent = parent
        }
        
        func textDidChange(_ notification: Notification) {
            DispatchQueue.main.async { [self] in
                guard let textView = notification.object as? NSTextView else { return }
                parent.code = textView.string
                selectedRanges = textView.selectedRanges
            }
        }
    }
    
    /// This method setups the language, thanks to which the code syntax is highlighted.
    /// - Returns: NSAttributedString which will be assigned to TextView
    private func setupLanguage() -> NSAttributedString? {
        TextView.highlightr?.highlight(TextView.textStorage.string,
                                       as: selectedLanguage,
                                       fastRender: true)
    }
}
