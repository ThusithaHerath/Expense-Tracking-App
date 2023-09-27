//
//  AuthViewModel.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-08-28.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol{
    var formIsValid: Bool {get}
}



@MainActor
class AuthViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    

    
    init(){
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUser()
        }
    }
    func signIn(withEmail email: String, password: String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch{
            print("DEBUG: Fail to log in with erro \(error.localizedDescription)")
        }
    }
    func createUser(withEmail email: String, password:String, fullname:String) async throws{
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch{
            print("DEBUG: Faild to create user with error \(error.localizedDescription)")
        }
    }
    func signOut(){
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch{
            print("DEBUG: Faild to sign out with error \(error.localizedDescription)")
        }
    }
    func deleteAccount(){
        let user = Auth.auth().currentUser
           if let user = user {
               user.delete { error in
                   if let error = error {
                       print("DEBUG: Failed to delete account with error \(error.localizedDescription)")
                   } else {
                       self.signOut()
                       print("DEBUG: Account deleted successfully")
                   }
               }
           } else {
               print("DEBUG: No user is currently signed in")
           }
    }
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: User.self)
    }
}
