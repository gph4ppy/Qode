//
//  UserDefaults+GetAndSetUIColors.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 29/04/2021.
//

import UIKit

extension UserDefaults {
    /// This method gets the UIColor from the given key (String).
    /// - Parameter key: The key with which the value will be associated.
    /// - Returns: Optional UIColor
    func colorForKey(key: String) -> UIColor? {
        var colorReturnded: UIColor?
        
        if let colorData = data(forKey: key) {
            do {
                if let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor {
                    colorReturnded = color
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return colorReturnded
    }
    
    /// This method sets the UIColor from the given key (String).
    /// - Parameters:
    ///   - color: The color to be assigned to the given key.
    ///   - key: The key with which the value will be associated.
    func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        
        if let color = color {
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) as NSData?
                colorData = data
            } catch {
                print(error.localizedDescription)
            }
        }
        
        set(colorData, forKey: key)
    }
}
