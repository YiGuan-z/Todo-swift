//
//  ItemInfoView.swift
//  TODO
//
//  Created by caseycheng on 2023/8/27.
//

import SwiftUI

struct ItemInfoView: View {
    let model:ItemModel
    var body: some View {
        ZStack{
            MarkDownTextView(markDownText: .constant(model.conetnt))
        }
    }
}

#Preview {
    ItemInfoView(model: ItemModel(title: "明天打游戏", isCompleted: false, content: "# 游戏历史 \r\n ## 游戏是我国一大传统，不得不品尝"))
}
