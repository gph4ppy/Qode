//
//  SavedDetailViewController+PresentableViews.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 24/05/2021.
//

import UIKit

// MARK: - Presentable Views
extension SavedDetailViewController {
    /// This opens up the UIActivityViewController which allows sharing the QR code.
    @objc func shareCode() {
        let child = SpinnerViewController()
        
        // Add the Spinner View Controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        // Initialize UIActivityViewController
        DispatchQueue.global(qos: .userInteractive).async {
            if let savedCode = self.savedCode {
                if let image = UIImage(data: savedCode.qrCode) {
                    let items: [Any] = [image, savedCode.title]
                    let ac = UIActivityViewController(activityItems: items, applicationActivities: [])
                    
                    // Stop ActivityIndicator and show UIActivityViewController
                    DispatchQueue.main.async {
                        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
                        self.present(ac, animated: true)
                        
                        child.willMove(toParent: nil)
                        child.view.removeFromSuperview()
                        child.removeFromParent()
                    }
                }
            }
        }
    }
}
