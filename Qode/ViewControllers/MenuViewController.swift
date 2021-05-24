//
//  MenuViewController.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 18/04/2021.
//

import UIKit
import StoreKit

final class MenuViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet var generateButton:       UIButton!
    @IBOutlet var scanButton:           UIButton!
    @IBOutlet var readButton:           UIButton!
    @IBOutlet var savedButton:          UIButton!
    @IBOutlet var settingsButton:       UIButton!
    
    // Properties
    private let accentColor: UIColor    = UserDefaults.standard.colorForKey(key: "accentColor") ?? .link
    private var startCounter            = UserDefaults.standard.integer(forKey: "startCounter")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Buttons
        Styling.styleMenuButtons(generateButton)
        Styling.styleMenuButtons(scanButton)
        Styling.styleMenuButtons(readButton)
        Styling.styleMenuButtons(savedButton)
        Styling.styleMenuButtons(settingsButton)
        
        // Set the NavBar accent color
        navigationController?.navigationBar.tintColor = accentColor
        
        // Increment the start number
        startCounter += 1
        UserDefaults.standard.setValue(startCounter, forKey: "startCounter")
        
        // Request the review when user used the application 10 times
        if startCounter == 10 {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
