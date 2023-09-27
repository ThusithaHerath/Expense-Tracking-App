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
    @State private var isEmailIncorrect = false
    @State private var isPasswordIncorrect = false
    @State private var emailErrorMessage = ""
    @State private var passwordErrorMessage = ""

    @EnvironmentObject var viewModel: AuthViewModel
    
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
                
                //sign in button
                Button{
                    Task{
                        try await viewModel.signIn(withEmail:email,password:password)
                    }
                }label: {
                    HStack{
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }.foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
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

//form validation 
extension LoginView: AuthenticationFormProtocol{
    var formIsValid: Bool{
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 6
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
