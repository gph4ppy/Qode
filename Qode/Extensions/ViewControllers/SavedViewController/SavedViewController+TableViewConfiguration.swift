//
//  SavedViewController+TableViewConfiguration.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 21/05/2021.
//

import UIKit

// MARK: - Table View Configuration
extension SavedViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.codes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCell", for: indexPath)
        let code = AppData.codes[indexPath.row]
        
        cell.textLabel?.text = code.title
        cell.detailTextLabel?.text = dateFormatter.string(from: code.date)
        cell.imageView?.image = UIImage(data: code.qrCode)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let code = AppData.codes[indexPath.row]
        let savedCode = DataToSave(title: code.title,
                                   code: code.code,
                                   qrCode: code.qrCode,
                                   language: code.language,
                                   date: code.date)
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "detailVC") as? SavedDetailViewController {
            vc.savedCode = savedCode
            navigationController?.pushViewController(vc, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let code = AppData.codes[indexPath.row]
            
            PersistenceController.context.delete(code)
            AppData.codes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            PersistenceController.saveContext()
        }
    }
}
