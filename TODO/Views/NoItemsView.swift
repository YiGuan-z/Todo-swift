//
//  NoItemsView.swift
//  TODO
//
//  Created by caseycheng on 2023/8/26.
//

import SwiftUI

struct NoItemsView: View {
    @State var animate:Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")
    var body: some View {
        ScrollView{
            VStack(spacing:10){
                Text("这里没有事件")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("你是一个有规划的人吗？点击添加按钮为你添加更多代办项目")
                    .padding(.bottom,20)
                
                
                NavigationLink {
                    AddView()
                } label: {
                    Text("添加")
                        .frame(width: 55)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .background(animate ? secondaryAccentColor : Color.accentColor)
                        .cornerRadius(10)
                }
                .padding(.horizontal,animate ? 30 : 50)
                .shadow(
                    color: animate ? secondaryAccentColor.opacity(0.7) : Color.accentColor.opacity(0.7),
                    radius: animate ? 30 : 10,
                    x: 0,
                    y: animate ? 50 : 30
                )
                .scaleEffect(animate ? 1.1 : 1.0)
                .offset(y: animate ? -7 : 0)

            }
            .frame(maxWidth: 400)
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
    }
    
    func addAnimation(){
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5){
            withAnimation(.linear(duration: 2).repeatForever()){
                animate.toggle()
            }
        }
    }
}

#Preview {
    NoItemsView()
}
