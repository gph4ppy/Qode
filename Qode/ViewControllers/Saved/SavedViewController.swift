//
//  SavedViewController.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 20/05/2021.
//

import UIKit
import CoreData

final class SavedViewController: UITableViewController {
    // Properties
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .long
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        fetchData()
    }
    
    /// This method fetches the data, loads it to the presented array and reloads the Table View.
    @objc func fetchData() {
        let viewContext = PersistenceController.context
        let fetchRequest: NSFetchRequest<SavedCode> = SavedCode.fetchRequest()
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            AppData.codes = results
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
