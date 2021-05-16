//
//  ScannedCodeViewController+PresentableViews.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 01/05/2021.
//

import UIKit

// MARK: - Presentable Views
extension ScannedCodeViewController {
    /// This method setups the ViewController components.
    internal func setupView() {
        // Set theme
        textStorage.highlightr.setTheme(to: selectedTheme)
        
        // Create layout manager
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        // Create text container
        let textContainer = NSTextContainer(size: CGSize(width: paddingView.bounds.width, height: paddingView.bounds.height - 10))
        layoutManager.addTextContainer(textContainer)
        
        // Create TextView
        let textView = UITextView(frame: paddingView.bounds, textContainer: textContainer)
        textView.attributedText = setupLanguage()
        textView.isEditable = false
        
        // Add TextView to the padding view
        paddingView.addSubview(textView)
        
        // Setup TextView constraints
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: paddingView.topAnchor),
            textView.bottomAnchor.constraint(equalTo: paddingView.bottomAnchor),
            
            textView.widthAnchor.constraint(equalTo: paddingView.widthAnchor),
            textView.heightAnchor.constraint(equalTo: paddingView.heightAnchor)
        ])
    }
}
