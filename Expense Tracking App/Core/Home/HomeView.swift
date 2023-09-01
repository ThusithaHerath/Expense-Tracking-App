//
//  HomeView.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-08-28.
//

import SwiftUI

struct HomeView: View {
    @Binding var showMenu: Bool
    var body: some View {
        VStack{
            VStack(spacing: 0){
                HStack{
                    Button{
                        withAnimation{showMenu.toggle()}
                    } label: {
                        Image(systemName: "text.justify")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                            
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical,10)
                
            }
            Spacer()
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
