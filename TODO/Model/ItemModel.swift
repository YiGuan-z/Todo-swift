//
//  ItemModel.swift
//  TODO
//
//  Created by caseycheng on 2023/8/25.
//

import Foundation


struct ItemModel:Identifiable, Codable {
    /// model id
    let id: String
    let title:String
    var conetnt:String
    var isCompleted:Bool
    let timestamp:Date
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool, timestamp: Date = .now,content:String) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.timestamp = timestamp
        self.conetnt = content
    }
    
    func updateCompleted()->Self{
        return ItemModel(id: self.id, title: self.title, isCompleted: !self.isCompleted,timestamp: self.timestamp,content:self.conetnt)
    }
}
