//
//  Item.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-15.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
