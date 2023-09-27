//
//  AddExpenseViewModel.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
@MainActor

class AddExpenseViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var alertMessage: String?

    func addExpense(for userId: String, category: String, amount: Double, description: String, location: String, date: Date) async -> String? {
        do {
            // Fetch the budget data for the selected category
            let budgetQuery = Firestore.firestore().collection("budgets")
                .whereField("userId", isEqualTo: userId)
                .whereField("category", isEqualTo: category)
                .limit(to: 1)
            
            let budgetQuerySnapshot = try await budgetQuery.getDocuments()
            
            if let budgetDocument = budgetQuerySnapshot.documents.first,
               var budgetData = budgetDocument.data() as? [String: Any],
               let budgetAmount = budgetData["amount"] as? Double {
                
                // Check if the budget is sufficient
                if amount <= (budgetAmount - (budgetData["Budget_expenses"] as? Double ?? 0.0)) {
                    // Create the expense document
                    let expenseData: [String: Any] = [
                        "userId": userId,
                        "date": date,
                        "category": category,
                        "amount": amount,
                        "description": description,
                        "location": location
                    ]
                    
                    // Add the expense to the expenses collection
                    _ = try await Firestore.firestore().collection("expenses").addDocument(data: expenseData)
                    
                    // Update Budget_expenses and balance in the budget document
                    let budgetExpenses = (budgetData["Budget_expenses"] as? Double ?? 0.0) + amount
                    let balance = budgetAmount - budgetExpenses
                    budgetData["Budget_expenses"] = budgetExpenses
                    budgetData["balance"] = balance
                    
                    // Update the budget document
                    try await Firestore.firestore().collection("budgets").document(budgetDocument.documentID).setData(budgetData)
                    
                    errorMessage = nil
                    alertMessage = "Expenses added successfully!"
                } else {
                    errorMessage = "Insufficient budget. Please adjust your budget."
                }
            } else {
                errorMessage = "Budget data not found. Please set a budget for the selected category."
            }
        } catch {
            errorMessage = "Failed to add expense. Please try again later."
        }
        return errorMessage
    }

}
