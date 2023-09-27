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
    
    func addBudget(for userId: String, category: String, amount: Double, period: Budget.Period) async -> String? {
        let incomeRef = Firestore.firestore().collection("income").whereField("userId", isEqualTo: userId)
        let documents = try? await incomeRef.getDocuments()
        if let doc = documents?.documents.first {
            let data = doc.data()
            let currentIncome = data["income"] as? Double ?? 0
            let currentExpenses = data["expenses"] as? Double ?? 0

            let newExpenses = currentExpenses + amount
            let balance = currentIncome - newExpenses

            if balance >= 0 {
                let budgetData: [String: Any] = [
                    "userId": userId,
                    "category": category,
                    "amount": amount,
                    "Budget_expenses": 0.0, 
                    "balance": amount - 0.0,
                    "period": period.rawValue
                ]
                
                do {
                    // Add budget to budgets collection
                    let _ = try await Firestore.firestore().collection("budgets").addDocument(data: budgetData)
                    
                    // Update expenses and balance in income collection
                    try await doc.reference.updateData([
                        "expenses": newExpenses,
                        "balance": balance
                    ])
                    return nil
                } catch {
                    return "Failed to add budget. Please try again later."
                }
            } else {
                return "Insufficient balance. Please adjust your budget."
            }
        } else {
            return "Failed to fetch income data. Please try again later."
        }

    }


}
