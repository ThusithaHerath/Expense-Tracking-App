//
//  BaseView.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-08-31.
//

import SwiftUI

struct BaseView: View {

    @State var currentTab = "Home"
    
    //offset for both drag gesture and showing menu
    @State var offset: CGFloat = 0
//    @State private var expenses = [Expense]()
    @State private var budget = [Budget]()
    
    var body: some View {
        
        NavigationView{
            
            HStack(spacing: 0){
                
                VStack(spacing: 0){
                    TabView(selection: $currentTab){
                        
                        HomeView()
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                            .tag("Home")
                        AddExpenses()
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                            .tag("Plus")
                        AddBudget(budgets: $budget)
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                            .tag("Dollar")
                        ProfileView()
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                            .tag("Gear")
                    }
                    
                    //custom tab bar
                    VStack(spacing: 0){
                        HStack(spacing: 0){
                            TabButton(image: "Home")
                            TabButton(image: "Plus")
                            TabButton(image: "Dollar")
                            TabButton(image: "Gear")
                        }
                        
                    }
                }
                .frame(width: getRect().width)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
      
    }
    
    @ViewBuilder
    func TabButton(image: String)->some View{
        Button{
            withAnimation{currentTab = image}
        } label: {
            Image(image)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
        }
    }

}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
