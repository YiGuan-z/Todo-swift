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
        NavigationLink(destination: {
            ItemInfoView(model: item)
        }, label: {
            HStack{
                Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                    .foregroundColor(item.isCompleted ? .green : .red)
                Text(item.title)
                    .foregroundColor(.black)
            }
        })
        
        
    }
}

fileprivate class data {
    static var item1 = ItemModel(title: "write a book", isCompleted: false,content: "# 你好")
    static var item2 = ItemModel(title: "write a paper", isCompleted: true,content: "# 你 *卧槽*")
}
#Preview {
    Group{
        NavigationView{
            ZStack{
                Color.green.opacity(0.7).ignoresSafeArea()
                VStack{
                    LisRowView(item: data.item1)
                    LisRowView(item: data.item2)
                }
            }
        }
    }
}
