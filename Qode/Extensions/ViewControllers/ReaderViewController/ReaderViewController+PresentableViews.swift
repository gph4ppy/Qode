//
//  ReaderViewController+PresentableViews.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 20/05/2021.
//

import UIKit

// MARK: - Presentable Views
extension ReaderViewController {
    /// This method setups the ViewController components.
    internal func setupView() {
        // Set theme
        highlightr?.setTheme(to: selectedTheme)
        
        // Create layout manager
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        // Create text container
        let textContainer = NSTextContainer(size: CGSize(width: codeView.bounds.width, height: codeView.bounds.height - 10))
        layoutManager.addTextContainer(textContainer)
        
        // Create TextView
        let textView = UITextView(frame: codeView.bounds, textContainer: textContainer)
        textView.delegate = self
        textView.attributedText = loadCode()
        textView.isEditable = false
        
        // Add TextView to the padding view
        codeView.addSubview(textView)
        
        // Setup TextView constraints
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: codeView.topAnchor),
            textView.bottomAnchor.constraint(equalTo: codeView.bottomAnchor),
            
            textView.widthAnchor.constraint(equalTo: codeView.widthAnchor),
            textView.heightAnchor.constraint(equalTo: codeView.heightAnchor)
        ])
    }
    
    /// This method shows the Image Picker Controller.
    @objc internal func importQRCode() {
        DispatchQueue.main.async { [self] in
            picker.delegate = self
            present(picker, animated: true)
        }
    }
}
