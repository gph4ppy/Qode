//
//  SettingsViewController.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 29/04/2021.
//

import UIKit
import Highlightr

final class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIColorPickerViewControllerDelegate, AlertPresenter {
    // Properties
    let highlightr                  = Highlightr()
    let colorPicker                 = UIColorPickerViewController()
    var selectedOption:             SelectedOption!
    let scannerAreaColor            = UserDefaults.standard.colorForKey(key: "scannerColor") ?? .systemYellow
    let accentColor: UIColor        = UserDefaults.standard.colorForKey(key: "accentColor") ?? .link
    var sections                    = [SettingsSection]()
    
    // Views
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTableView()
        colorPicker.delegate = self
    }
    
    /// This method loads the TableView.
    func loadTableView() {
        configure()
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        switch selectedOption {
        case .scannerAreaColor:
            UserDefaults.standard.setColor(color: viewController.selectedColor, forKey: "scannerColor")
        case .accentColor:
            UserDefaults.standard.setColor(color: viewController.selectedColor, forKey: "accentColor")
            navigationController?.navigationBar.tintColor = viewController.selectedColor
        default:
            print("⚠️ There is no way to display a color picker with this option.")
        }
    }
}
