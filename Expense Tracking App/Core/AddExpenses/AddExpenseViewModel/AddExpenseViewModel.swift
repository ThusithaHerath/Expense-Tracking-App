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

    func addExpense(for userId: String, category: String, amount: Double, description: String, location: String, date: Date) async {
        let expenseData: [String: Any] = [
                   "userId": userId,
                   "date": date,
                   "category": category,
                   "amount": amount,
                   "description": description,
                   "location": location
               ]
        do {
                   let _ = try await Firestore.firestore().collection("expenses").addDocument(data: expenseData)
               } catch {
                   print("Failed to add expense: \(error)")
               }
    }
    
}
