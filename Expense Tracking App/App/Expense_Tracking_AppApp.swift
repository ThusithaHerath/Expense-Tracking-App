//
//  Expense_Tracking_AppApp.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-08-24.
//

import SwiftUI
import Firebase

@main
struct Expense_Tracking_AppApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
