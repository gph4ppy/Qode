//
//  MenuViewController.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 18/04/2021.
//

import UIKit

class MenuViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet var generateButton:       UIButton!
    @IBOutlet var scanButton:           UIButton!
    @IBOutlet var settingsButton:       UIButton!
    
    // Properties
    private let accentColor: UIColor    = UserDefaults.standard.colorForKey(key: "accentColor") ?? .link
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Buttons
        Styling.styleMenuButtons(generateButton)
        Styling.styleMenuButtons(scanButton)
        Styling.styleMenuButtons(settingsButton)
        
        // Set the NavBar accent color
        navigationController?.navigationBar.tintColor = accentColor
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
