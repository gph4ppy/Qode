//
//  SavedCode+CoreDataProperties.swift
//  
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 20/05/2021.
//
//

import Foundation
import CoreData

extension SavedCode {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedCode> {
        return NSFetchRequest<SavedCode>(entityName: "SavedCode")
    }

    @NSManaged public var qrCode: Data
    @NSManaged public var date: Date
    @NSManaged public var code: String
    @NSManaged public var title: String
    @NSManaged public var language: String
}
