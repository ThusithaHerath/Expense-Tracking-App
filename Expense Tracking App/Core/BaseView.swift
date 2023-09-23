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
    
    var body: some View {
        
        NavigationView{
            
            HStack(spacing: 0){
                
                VStack(spacing: 0){
                    TabView(selection: $currentTab){
                        
                        HomeView()
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                            .tag("Home")
                        Text("Add expenses")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                            .tag("Plus")
                        Text("Dollar")
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
                        
                        Divider()
                        
                        HStack(spacing: 0){
                            TabButton(image: "Home")
                            TabButton(image: "Plus")
                            TabButton(image: "Dollar")
                            TabButton(image: "Gear")
                        }
                        .padding(.top,10)
                    }
                }
                .frame(width: getRect().width)
            }
            .offset(x: offset)
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
