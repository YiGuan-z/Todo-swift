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
        VStack{
            ZStack{
                if listViewModel.items.isEmpty{
                    NoItemsView()
                        .transition(.opacity.animation(.bouncy))
                }else{
                    List{
                        ForEach(listViewModel.items){ item in
                            LisRowView(item: item)
                                .swipeActions{
                                    Button{
                                        if let index = listViewModel.items.firstIndex (where:{ $0.id == item.id }){
                                            let indexSet = IndexSet(integer: index)
                                            listViewModel.deleteItem(indexSet: indexSet)
                                        }
                                        
                                    } label: {
                                        Text("删除")
                                    }
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
                
            }
            .navigationTitle("Todo list")
            .navigationBarItems(leading: EditButton(),trailing: NavigationLink("Add", destination: AddView()))
            
            Button(action: {
                /// TODO: 被选择时显示全部已完成和全部未完成
            }, label: {
                Text("Button")
            })
        }
        
    }
}

extension ContentView{
    
}

#Preview {
    NavigationView{
        ContentView()       
    }
    .environmentObject(ListViewModel())
}
