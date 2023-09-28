//
//  ProfileView.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-08-28.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showingDeleteConfirmationAlert = false
    @State private var isShowingReports = false

    
    var body: some View {
        if let user = viewModel.currentUser{
            List {
                Section{
                    HStack{
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        
                        VStack{
                            Text(user.fullname)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            Text(user.email)
                                .font(.footnote)
                                .accentColor(.gray)
                        }
                    }
                }
                Section("General"){
                    HStack{
                        SettingRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                        Spacer()
                        
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                Section("Reports"){
                    HStack{
                        SettingRowView(imageName: "doc", title: "See Reports", tintColor: Color(.systemGray))
                        Spacer()
                        NavigationLink(destination: ReportView(), isActive: $isShowingReports) {
                           EmptyView()
                        }
                        .hidden()
                
                    }
                    .onTapGesture {
                        isShowingReports = true  // Activate the NavigationLink when tapped
                    }
                }
                Section("Account"){
                    Button{
                        viewModel.signOut()
                    } label: {
                        SettingRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: .red)
                    }
                    
                    Button{
                        showingDeleteConfirmationAlert = true
                    } label: {
                        SettingRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: .red)
                    }.alert(isPresented: $showingDeleteConfirmationAlert) {
                        Alert(
                            title: Text("Delete Account"),
                            message: Text("Are you sure you want to delete your account? This action cannot be undone."),
                            primaryButton: .destructive(Text("Delete")) {
                                // Call the deleteAccount function here
                                viewModel.deleteAccount()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
