//
//  LisRowView.swift
//  TODO
//
//  Created by caseycheng on 2023/8/26.
//

import SwiftUI

struct LisRowView: View {
    var dateFormatter:DateFormatter?
    let item:ItemModel
    
    init(dateFormatter: DateFormatter? = nil, item: ItemModel) {
        self.dateFormatter = dateFormatter
        self.item = item
    }
    
    var body: some View {
        HStack{
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
            Text(item.title)
//            if let dateFormatter{
//                Text(dateFormatter.string(from: item.timestamp))
//            }else{
//                Text(item.timestamp.formatted())
//            }
        }
    }
}

fileprivate class data {
    static var item1 = ItemModel(title: "write a book", isCompleted: false)
    static var item2 = ItemModel(title: "write a paper", isCompleted: true)
}
#Preview {
    Group{
        LisRowView(item: data.item1)
        LisRowView(item: data.item2)
    }
    .previewLayout(.sizeThatFits)
}
