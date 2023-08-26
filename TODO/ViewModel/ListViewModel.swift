//
//  ListViewModel.swift
//  TODO
//
//  Created by caseycheng on 2023/8/25.
//

import Foundation

class ListViewModel:ObservableObject{
    @Published var items:[ItemModel] = [] {
        didSet {
           saveItems()
        }
    }
    
    let itemsKey:String = "items_list"
    private var encoder = JSONEncoder()
    private var decoder = JSONDecoder()
    
    init() {
        loadData()
    }
    
    func loadData(){
        let data = UserDefaults.standard.data(forKey: itemsKey)
        
        if let data,let savedItems = try? decoder.decode([ItemModel].self, from: data){
            self.items = savedItems
        }else{
            self.items = []
        }
    }
    
    func addItem(title:String){
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func deleteItem(indexSet:IndexSet){
        self.items.remove(atOffsets: indexSet)
    }
    
    func updateItem(_ item:ItemModel){
        if let index = self.items.firstIndex(where: {item.id == $0.id}){
            items[index] = item.updateCompleted()
        }
    }
    
    func moveItem(from:IndexSet,to:Int){
        self.items.move(fromOffsets: from, toOffset: to)
    }
    
    func saveItems(){
        if let encodeData = try? encoder.encode(items){
            UserDefaults.standard.set(encodeData, forKey: self.itemsKey)
        }
    }
    
}
