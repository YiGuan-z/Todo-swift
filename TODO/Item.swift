//
//  Item.swift
//  TODO
//
//  Created by caseycheng on 2023/8/25.
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
