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
    
    @State var textFieldText:String = ""
    @State var alertTitle:String = ""
    @State var showAlert:Bool = false
    @State var conetnt:String = ""
    var body: some View {
//        ScrollView{
            VStack{
                TextField("事件名称", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                
                TextEditor(text: $conetnt)
                    .frame(height: AppState.screenHight*0.6)
                    .background(Color.red)

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
            .padding(14)
//        }
        .navigationTitle("添加活动")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed(){
        if textIsApproriate(){
            self.listViewModel.addItem(title: self.textFieldText,content: self.conetnt)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsApproriate()->Bool{
        if textFieldText.isEmpty{
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
