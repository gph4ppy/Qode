//
//  GeneratorViewController+PresentableViews.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 01/05/2021.
//

import UIKit

// MARK: - Presentable Views
extension GeneratorViewController {
    /// This method setups the ViewController components.
    func setupView() {
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
        textView.delegate = self
        textView.attributedText = setupLanguage()
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        textView.returnKeyType = .done
        
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
    
    /// This method shows the ViewController which has a QR code generated.
    @objc func generateQRCode() {
        let code = textStorage.string
        var alert: UIAlertController!
        
        DispatchQueue.main.async { [self] in
            if code.count >= 2200 {
                // Check that the code is not too long.
                // In theory, the QR code can hold up to about 4000 characters, but above 2200 it doesn't work, because the input data is too big.
                alert = createAlert(title: LocalizedStrings.notTooMuch,
                                    message: LocalizedStrings.tooLongCode,
                                    action: LocalizedStrings.ok)
                present(alert, animated: true)
            } else if code.count == 0 {
                // Check if the code is not empty.
                alert = createAlert(title: LocalizedStrings.emptyCode,
                                    message: LocalizedStrings.emptyCodeBody,
                                    action: LocalizedStrings.ok)
                present(alert, animated: true)
            } else if checkForIllegalCharacters(string: code) || code.containsEmoji {
                // Check if the code does not contain illegal characters.
                alert = createAlert(title: LocalizedStrings.illegalCharacters,
                                    message: LocalizedStrings.illegalCharactersAlert,
                                    action: LocalizedStrings.ok)
                present(alert, animated: true)
            } else {
                // Show ViewController with generated QR code.
                if let vc = storyboard?.instantiateViewController(identifier: "generatedCodeVC") as? QRCodeOutputViewController {
                    vc.code = code
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}
