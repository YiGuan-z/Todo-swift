//
//  ContentView.swift
//  TODO
//
//  Created by caseycheng on 2023/8/25.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var listViewModel:ListViewModel
 
    var body: some View{
        ZStack{
            Theme.blackAndBlueGradient.ignoresSafeArea()
            
            VStack{
                ZStack{
                    if listViewModel.items.isEmpty{
                        NoItemsView()
                            .transition(.opacity.animation(.bouncy))
                            .foregroundColor(.white)
                    }else{
                        todoListView
                    }
                    
                }
                .navigationTitle("Todo list")
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: 
                        NavigationLink("Add",destination: AddView())
                )
                
                
            }
        }
    }
}

extension ContentView{
    private var todoListView:some View{
        List{
            ForEach(listViewModel.items){ item in
                LisRowView(item: item)
                    .listRowBackground(Color.white.opacity(0.1))
                    .swipeActions{
                        Button(action: {deleteItem(item: item)}, label: {
                            Text("删除")
                        })
                        .tint(.red)
                    }
                    .swipeActions(edge:.leading){
                        Button {
                            withAnimation(.linear){
                                listViewModel.updateItem(item)
                            }
                        } label: {
                            Text(item.isCompleted ? "未完成":"已完成")
                        }
                        .tint(item.isCompleted ? .yellow : .green)
                    }
                    
                    
            }
            .onDelete(perform: listViewModel.deleteItem(indexSet:))
            .onMove(perform: listViewModel.moveItem(from:to:))
            
            
        }
        .listStyle(PlainListStyle())

    }
    
    private func deleteItem(item:ItemModel){
        if let index = listViewModel.items.firstIndex (where:{ $0.id == item.id }){
            let indexSet = IndexSet(integer: index)
            withAnimation(.spring){
                listViewModel.deleteItem(indexSet: indexSet)
            }
        }
    }
    
}

#Preview {
    NavigationView{
        ContentView()
    }
    .environmentObject(ListViewModel())
}
