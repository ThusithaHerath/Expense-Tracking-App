//
//  BudgetViewModel.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
@MainActor
class BudgetViewModel: ObservableObject {
    
    func addBudget(for userId: String, category: String, amount: Double, period: Budget.Period) async {
        let budgetData: [String: Any] = [
            "userId": userId,
            "category": category,
            "amount": amount,
            "period": period.rawValue
        ]
        
        do {
            let _ = try await Firestore.firestore().collection("budgets").addDocument(data: budgetData)
        } catch {
            print("Failed to add budget: \(error)")
        }
    }
}
