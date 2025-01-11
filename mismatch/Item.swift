//
//  Item.swift
//  mismatch
//
//  Created by Kunal Kamble on 10/01/25.
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
