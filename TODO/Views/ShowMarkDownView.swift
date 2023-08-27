//
//  ShowMarkDownView.swift
//  TODO
//
//  Created by caseycheng on 2023/8/27.
//

import SwiftUI

struct ShowMarkDownView: View {
    @Binding var content:String
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        VStack{
            ZStack{
                MarkDownTextView(markDownText: _content)
                    .allowVerticalPull()
            }
            .padding()
            .navigationBarBackButtonHidden()
            Button {
                //返回上一级
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("返回")
                    .withTextToButtonLabel(fontColor: .white, font: .title, backgroundColor: .blue)
                    .padding()
            }

        }
    }
}

#Preview {
    NavigationView{
        ShowMarkDownView(content: .constant("# Hello"))
    }
}
