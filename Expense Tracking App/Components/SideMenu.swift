//
//  SideMenu.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-08-29.
//

import SwiftUI

struct SideMenu: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var showMenu: Bool
    @State var isProfileTap = false
    @State private var isProfileActive = false
    

    
    var body: some View {
        NavigationView{
            
            VStack(alignment: .leading,spacing: 0){
                HStack(spacing: 0){
                    Image("ExpenseTrackerLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 65, height: 65)
                        .clipShape(Circle())
                    VStack{
                        Text("Expense Tracker")
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        Text("Track it Save it")
                            .font(.footnote)
                            .accentColor(.gray)
                    }
                }
                .padding(.horizontal)
                .padding(.leading)
                
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        VStack(alignment: .leading,spacing: 45){
                            
                            
                            //tab buttons
//                            NavigationView {
//                                        VStack {
//                                            Text("Hello World")
//                                            NavigationLink(destination: ProfileView()) {
//                                                Text("Do Something")
//                                            }
//                                        }
//                                    }
                            TabButton(title: "Profile", image: "Profile")
                            TabButton(title: "About", image: "Info")
                            TabButton(title: "Settings", image: "Gear")
                            TabButton(title: "Log Out", image: "Power")
                                .onTapGesture {
                                    viewModel.signOut()
                                }


                        }
                        .padding()
                        .padding(.leading)
                        .padding(.top, 20)
                        
                    }
                }
                
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            //max width
            .frame(width: getRect().width - 90)
            .frame(maxHeight: .infinity)
            .background(
                Color.primary
                    .opacity(0.04)
                    .ignoresSafeArea(.container, edges: .vertical)
            )
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationBarHidden(true)
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
