//
//  IncomeViewModel.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-28.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
class IncomeReportViewModel: ObservableObject {
    @Published var incomeData: IncomeData?
    @Published var userData: UserData?
    
    func fetchData(for userId: String) {
        print("Fetching user data for userId: \(userId)")
        let _: Void = Firestore.firestore().collection("users").document(userId).getDocument { snapshot, error in
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
                return
            }
            
            if let userData = try? snapshot?.data(as: UserData.self) {
                self.userData = userData
                print("User data fetched successfully: \(userData)")

            }
        }
        
        let _: Void = Firestore.firestore().collection("income").whereField("userId", isEqualTo: userId).getDocuments { snapshot, error in
             if let error = error {
                 print("Error fetching income data: \(error.localizedDescription)")
                 return
             }
             
             guard let documents = snapshot?.documents else { return }
             
             if let incomeData = try? documents[0].data(as: IncomeData.self) {
                 self.incomeData = incomeData
             }
         }
        
    }
        
}

struct UserData: Identifiable, Codable {
    @DocumentID var id: String?
    var fullname: String
    var email: String
}


struct IncomeData: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String
    var income: Double
    var expenses: Double
    var balance: Double
}

