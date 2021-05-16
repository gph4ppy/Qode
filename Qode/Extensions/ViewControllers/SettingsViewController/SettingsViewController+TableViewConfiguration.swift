//
//  SettingsViewController+TableViewConfiguration.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 02/05/2021.
//

import UIKit

// MARK: - Table View Configuration
extension SettingsViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else { return UITableViewCell() }
        let option = sections[indexPath.section].options[indexPath.row]
        
        cell.configure(with: option)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = sections[indexPath.section].options[indexPath.row]
        option.handler()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sections[section]
        return section.title
    }
}
