//
//  BudgetTab.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-28.
//

import SwiftUI

struct BudgetTab: View {
    @StateObject private var budgetReportViewModel =   BudgetReportViewModel()
    @EnvironmentObject var viewModel: AuthViewModel

    @State private var selectedCategory = ""
    @State private var budgets: [Budget] = []



    var body: some View {
        VStack{
            Text("Budget Report")
                .font(.title)
                .padding()
            
            HStack {
                   Text("Select Category")
                    .frame(width: 100, alignment: .leading)
                
                   Picker("Category", selection: $selectedCategory) {
                       ForEach(budgetReportViewModel.categories, id: \.self) { categoryName in
                           Text(categoryName).tag(categoryName)
                       }
                   }
                   .pickerStyle(DefaultPickerStyle())
                   .frame(maxWidth: .infinity)
               }
               .padding()
               .background(
                   RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
               )
               .padding()
            
            Button("Generate Report") {
                if let userId = viewModel.userSession?.uid {
                       print("Selected Category: \(selectedCategory)")
                       Task {
                           budgetReportViewModel.generateReport(userId: userId, selectedCategory: selectedCategory) { budgets in
                                      self.budgets = budgets
                                  }
                       }
                   }
            }
            .padding(10)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .frame(width: 200)
            
            
            // Display budget data here
            if !budgets.isEmpty {
                List(budgets) { budget in
                        HStack {
                            Text("Category:")
                            Text(String(budget.category ))
                        }
                        HStack {
                            Text("Amount:")
                            Text(String(format: "%.2f", budget.amount ))
                        }
                        HStack {
                            Text("Expenses:")
                            Text(String(format: "%.2f", budget.Budget_expenses ))
                        }
                        HStack {
                            Text("Balance:")
                            Text(String(format: "%.2f", budget.balance ))
                        }
                        HStack {
                            Text("Category:")
                            Text(budget.period.rawValue)
                        }
                    
            }
            } else {
                Text("No budget data found.")
            }
            
            Button("Download PDF") {
               
            }
            .padding()
        }
        .onAppear {
            if let userId = viewModel.userSession?.uid {
             Task {
                 await budgetReportViewModel.fetchCategories(for: userId)
              }
           }
       }
        
    }
}

struct BudgetTab_Previews: PreviewProvider {
    static var previews: some View {
        BudgetTab()
    }
}
