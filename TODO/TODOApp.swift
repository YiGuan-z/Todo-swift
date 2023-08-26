//
//  TODOApp.swift
//  TODO
//
//  Created by caseycheng on 2023/8/25.
//

import SwiftUI

@main
struct TODOApp: App {
    @StateObject var listViewModel = ListViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listViewModel)
            
        }
    }
}
