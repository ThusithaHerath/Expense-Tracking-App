//
//  CategoryTab.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-28.
//

import SwiftUI

struct Categoryy: Identifiable, Codable {
    var id: String
    var categoryName: String
}
struct CategoryTab: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @StateObject private var categoryReportViewModel = CategoryReportViewModel()
    
    var body: some View {
        VStack {
            Text("Category Report")
                .font(.title)
                .padding()
            if !$categoryReportViewModel.categories.isEmpty {
                            List(categoryReportViewModel.categories) { category in
                                Text(category.categoryName) // Use 'category.categoryName' here
                            }
                            .listStyle(PlainListStyle())
                        } else {
                            Text("No categories found.")
                        }
            
            Button("Download PDF") {
            }
            .padding()
        }
        .onAppear {
            if let userId = viewModel.userSession?.uid {
                print("Fetching categories for userId: \(userId)")
                categoryReportViewModel.fetchCategories(for: userId)
            }
        }
    }
}

struct CategoryTab_Previews: PreviewProvider {
    static var previews: some View {
        CategoryTab()
    }
}
