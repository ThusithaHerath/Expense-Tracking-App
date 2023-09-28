//
//  ExpensesReportViewModel.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-28.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
class ExpensesReportViewModel: ObservableObject {
    @Published var expenses: [Expenses] = []
    
    func generateReport(userId: String, selectedCategory: String){
        print("Generating report for userId: \(userId), category: \(selectedCategory)")
        
        Firestore.firestore().collection("expenses")
                   .whereField("userId", isEqualTo: userId)
                   .whereField("category", isEqualTo: selectedCategory)
                   .getDocuments { [weak self] snapshot, error in
                       if let error = error {
                           print("Error fetching expenses: \(error.localizedDescription)")
                           return
                       }
                       
                       guard let documents = snapshot?.documents else {
                           print("No expenses found for the selected category.")
                           return
                       }
                       
                       let expenses = documents.compactMap { document -> Expenses? in
                           try? document.data(as: Expenses.self)
                       }
                       
                       DispatchQueue.main.async {
                           self?.expenses = expenses
                       }
                   }
    }
}
