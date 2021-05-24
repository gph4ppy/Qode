//
//  Styling.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 29/04/2021.
//

import UIKit

final class Styling {
    static public let cornerRadius: CGFloat = 25
    
    /// This method sets the appearance of the menu buttons.
    /// - Parameter button: The button whose appearance will be changed.
    static public func styleMenuButtons(_ button: UIButton) {
        button.layer.cornerRadius = cornerRadius
        button.layer.backgroundColor = UIColor.darkGray.cgColor
        button.tintColor = .white
        button.layer.cornerCurve = .continuous
    }
    
    /// This method sets a mask with a rectangle hole inside the view. 
    /// - Parameters:
    ///   - area: mask - rectangle hole
    ///   - view: view which will be masked
    static public func setMask(with area: CGRect, in view: UIView) {
        // Create a mutable path and add a rectangle hole
        let mutablePath = CGMutablePath()
        mutablePath.addRect(view.bounds)
        mutablePath.addRoundedRect(in: area, cornerWidth: cornerRadius, cornerHeight: cornerRadius)

        // Create a shape layer and cut out the intersection
        let mask = CAShapeLayer()
        mask.path = mutablePath
        mask.fillRule = CAShapeLayerFillRule.evenOdd

        // Add the mask to the view
        view.layer.mask = mask
    }
}
