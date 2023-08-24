//
//  LoginView.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-08-24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        NavigationStack{
            VStack{
                Image("ExpenseTrackerLogo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height:120)
                    .padding(.vertical,32)
                //form fields
                VStack(spacing: 24){
                    InputView(text: $email, title: "Email Address", placeholder: "thusi@gmail.com")
                        .autocapitalization(.none)
                    InputView(text: $password, title: "Password", placeholder: "Enter Your Password", isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top,20)
                
                Button{
                    print("Log user in")
                }label: {
                    HStack{
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }.foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(10)
                .padding(.top, 24)
                Spacer()
                
                NavigationLink{
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                }label: {
                    HStack{
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
