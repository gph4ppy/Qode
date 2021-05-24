//
//  SavedDetailViewController+ViewSetup.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 23/05/2021.
//

import UIKit

// MARK: - View Setup
extension SavedDetailViewController {
    /// This method loads the image into the ImageView
    func loadImage() {
        guard let savedCode = self.savedCode else { return }
        
        if let image = UIImage(data: savedCode.qrCode) {
            DispatchQueue.main.async {
                self.qrCodeImageView.image = image
            }
        }
    }
    
    /// This method setups the ViewController components.
    internal func setupView() {
        // Set theme
        textStorage.highlightr.setTheme(to: selectedTheme)
        
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
    
    /// This method setups the language, thanks to which the code syntax is highlighted.
    /// - Returns: NSAttributedString which will be assigned to TextView
    internal func loadCode() -> NSAttributedString? {
        if let savedCode = self.savedCode {
            textStorage.language = savedCode.language.capitalizingFirstLetter()
            return highlightr?.highlight(savedCode.code, as: savedCode.language)
        }
        
        return nil
    }
}
