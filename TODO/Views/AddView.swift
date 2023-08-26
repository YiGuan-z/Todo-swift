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
    var body: some View {
        ScrollView{
            VStack{
                TextField("在这里输入", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                
                Button(action: saveButtonPressed, label: {
                    Text("save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            }
            .padding(14)
        }
        .navigationTitle("添加事件")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed(){
        if textIsApproriate(){
            self.listViewModel.addItem(title: self.textFieldText)
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
