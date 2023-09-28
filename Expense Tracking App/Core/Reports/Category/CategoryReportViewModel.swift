//
//  CategoryReportViewModel.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-28.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
class CategoryReportViewModel: ObservableObject {
    @Published var categories: [Category] = []

    func fetchCategories(for userId: String) {

           Firestore.firestore().collection("category").whereField("userId", isEqualTo: userId).getDocuments { snapshot, error in
                   if let error = error {
                       print("Error fetching categories: \(error.localizedDescription)")
                       return
                   }
                   
                   guard let documents = snapshot?.documents else { return }
                   let categories = documents.compactMap { document -> Category? in
                       try? document.data(as: Category.self)
                   }
               print("Fetching for userId: \(categories)")

                   
                   DispatchQueue.main.async {
                       self.categories = categories
                   }
               }
       }
}

