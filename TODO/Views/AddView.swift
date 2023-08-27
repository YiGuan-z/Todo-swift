//
//  AddView.swift
//  TODO
//
//  Created by caseycheng on 2023/8/26.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var listViewModel:ListViewModel
    
    @State var title:String = ""
    @State var alertTitle:String = ""
    @State var showAlert:Bool = false
    @State var conetnt:String = ""
    
    var body: some View {
            VStack{
                ScrollView{
                    VStack{
                        TextField("事件名称", text: $title)
                            .padding(.horizontal)
                            .frame(height: 55)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(10)
                        
                        TextEditor(text: $conetnt)
                            .frame(height: AppState.screenHight*0.6)
                    }
                    .padding(14)
                    .navigationTitle("添加活动")
                    .alert(isPresented: $showAlert, content: getAlert)
                }
                Spacer()
                
                bottomfloatingButton
                    .padding(14)
            }
        }

    
    func saveButtonPressed(){
        if textIsApproriate(){
            self.listViewModel.addItem(title: self.title,content: self.conetnt)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsApproriate()->Bool{
        if title.isEmpty{
            alertTitle = "事件名称不能为空"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert()->Alert{
        return Alert(title: Text(self.alertTitle))
    }
}

extension AddView{
    private var bottomfloatingButton:some View{
        HStack{
            NavigationLink {
                ShowMarkDownView(content: $conetnt)
            } label: {
                Text("查看效果")
                    .withTextToButtonLabel(fontColor: .white, font: .headline, backgroundColor: .green)
            }
            
            Button(action: saveButtonPressed, label: {
                Text("save".uppercased())
                    .withTextToButtonLabel(fontColor: .white, font: .headline, backgroundColor: .accentColor)
            })
        }
    }
}

#Preview("dark") {
        NavigationView{
            AddView()
        }
        .preferredColorScheme(.dark)
        .environmentObject(ListViewModel())
}
#Preview("light") {
        NavigationView{
            AddView()
        .preferredColorScheme(.light)
        .environmentObject(ListViewModel())
        
    }
}
