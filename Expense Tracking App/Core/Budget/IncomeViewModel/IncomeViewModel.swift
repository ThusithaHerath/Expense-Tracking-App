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
    
}
