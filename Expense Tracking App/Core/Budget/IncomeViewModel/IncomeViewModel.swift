//
//  IncomeViewModel.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-24.
//

import Foundation

import Firebase
import FirebaseFirestoreSwift

@MainActor
class IncomeViewModel: ObservableObject {
    @Published var userIncome: Double?
    @Published var userExpenses: Double?
    @Published var userBalance: Double?


    //store category
    func addIncome(for userId: String, income: Double) async {
        let incomeData : [String: Any] = [
            "userId": userId,
            "income": income
        ]
        
        do {
            let _ = try await Firestore.firestore().collection("income").addDocument(data: incomeData)
        } catch {
            print("DEBUG: Failed to add category with error \(error.localizedDescription)")
        }
    }
    
    func fetchIncome(for userId: String) async {
        let incomeRef = Firestore.firestore().collection("income").whereField("userId", isEqualTo: userId)

            do {
                let documents = try await incomeRef.getDocuments()
                if let firstDocument = documents.documents.first {
                    self.userIncome = firstDocument.data()["income"] as? Double
                    self.userExpenses = firstDocument.data()["expenses"] as? Double
                    self.userBalance = firstDocument.data()["balance"] as? Double
                } else {
                    self.userIncome = nil
                    self.userExpenses = nil
                    self.userBalance = nil
                }
            } catch {
                print("DEBUG: Failed to fetch income with error \(error.localizedDescription)")
            }
    }
    
    

   

    
}
