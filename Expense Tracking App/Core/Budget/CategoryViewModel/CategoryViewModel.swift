//
//  CategoryViewModel.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-24.
//

import Foundation
// CategoryViewModel.swift
import Firebase
import FirebaseFirestoreSwift

@MainActor
class CategoryViewModel: ObservableObject {
    @Published var categories: [String] = []

    
    //store category
    func addCategory(for userId: String, categoryName: String) async {
        let categoryData = [
            "userId": userId,
            "categoryName": categoryName
        ]
        
        do {
            let _ = try await Firestore.firestore().collection("category").addDocument(data: categoryData)
        } catch {
            print("DEBUG: Failed to add category with error \(error.localizedDescription)")
        }
    }
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

}

