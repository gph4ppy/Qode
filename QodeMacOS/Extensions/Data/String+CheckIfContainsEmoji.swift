//
//  String+CheckIfContainsEmoji.swift
//  QodeMacOS
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 14/06/2021.
//

import Foundation

extension String {
    var containsEmoji: Bool { contains { $0.isEmoji } }
}

extension Character {
    /// A simple emoji is one scalar and presented to the user as an Emoji
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }
    
    /// Checks if the scalars will be merged into an emoji
    var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }
    
    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
}
