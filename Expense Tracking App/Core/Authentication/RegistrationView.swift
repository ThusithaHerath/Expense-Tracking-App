//
//  RegistrationView.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-08-24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            VStack{
                Image("ExpenseTrackerLogo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height:120)
                    .padding(.vertical,32)
                //registration form
                VStack(spacing: 24) {
                    InputView(text: $email, title: "Email", placeholder: "Enter your email address")
                    InputView(text: $fullname, title: "Full Name", placeholder: "Thusitha Herath")
                    InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                    InputView(text: $confirmPassword, title: "Confirm Password", placeholder: "Confirm your password", isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                Button{
                    print("Sign up..")
                }label: {
                    HStack{
                        Text("SIGN UP")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }.foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(10)
                .padding(.top, 24)
                Spacer()
                
                Button{
                    dismiss()
                }label: {
                    HStack{
                        Text("Already have an account?")
                        Text("Sign in")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                    
                }
                
            }
        }
    }
    
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
