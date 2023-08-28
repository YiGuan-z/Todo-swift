//
//  ItemInfoView.swift
//  TODO
//
//  Created by caseycheng on 2023/8/27.
//

import SwiftUI

struct ItemInfoView: View {
    private let model:ItemModel
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var vm:ListViewModel
    init(model: ItemModel) {
        self.model = model
    }
    var body: some View {
        VStack{
            Text(model.title)
                .font(.title)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Image(systemName: "arrowshape.turn.up.backward")
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
            
            Text(model.timestamp.formatted())
            Rectangle()
                .frame(height: 2)
            
            MarkDownTextView(markDownText: .constant(model.conetnt))
                .allowVerticalPull()
            
            
            
            HStack{
                Button(action: {
                    if let index = vm.items.firstIndex(where: {$0.id == model.id}){
                        vm.deleteItem(indexSet: IndexSet(integer: index))
                        presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                    Text("删除")
                        .withTextToButtonLabel(fontColor: .white, font: .title3.bold(), backgroundColor: .red)
                })
                Button(action: {
                    vm.updateItem(model)
                }, label: {
                    Text(model.isCompleted ? "标记为未完成" : "标记为已完成")
                        .withTextToButtonLabel(fontColor: .white, font: .title3.bold(), backgroundColor: model.isCompleted ? .yellow : .green)
                })
            }
        }
        .padding()
//        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationView{
        ItemInfoView(model: ItemModel(title: "明天打游戏", isCompleted: false, content: "# 游戏历史 \r\n ## 游戏是我国一大传统，不得不品尝"))
            .environmentObject(ListViewModel())
    }
}
