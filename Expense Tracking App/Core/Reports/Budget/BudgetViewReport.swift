//
//  BudgetViewReport.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-28.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
class BudgetReportViewModel: ObservableObject {
    @Published var categories: [String] = []
    @Published var budgets: [Budget] = [] 

    
    //get all categories assigned to auth user
    func fetchCategories(for userId: String) async {
            let query = Firestore.firestore().collection("category").whereField("userId", isEqualTo: userId)
            
            do {
                let documents = try await query.getDocuments()
                categories = documents.documents.compactMap { document in
                    return document.get("categoryName") as? String
                }
            } catch {
                print("Failed to fetch categories: \(error)")
            }
    }
    
    func generateReport(userId: String, selectedCategory: String, completion: @escaping ([Budget]) -> Void){
        print("Generating report for userId: \(userId), category: \(selectedCategory)")
          
        let query =  Firestore.firestore().collection("budgets")
                    .whereField("userId", isEqualTo: userId)
                    .whereField("category", isEqualTo: selectedCategory) // Filter by selected category
        
                    query.getDocuments { [weak self] snapshot, error in
                        if let error = error {
                            print("Error fetching budgets: \(error.localizedDescription)")
                            return
                        }

                        guard let documents = snapshot?.documents else {
                            print("No budgets found for the selected category.")
                            return
                        }
                        print("Fetched \(documents.count) documents")

                        let budgets = documents.compactMap { document -> Budget? in
                            try? document.data(as: Budget.self)
                        }
                        print("Parsed \(budgets.count) budgets")

                        self?.budgets = budgets
                        
                        completion(budgets)

                    }
    }

}

