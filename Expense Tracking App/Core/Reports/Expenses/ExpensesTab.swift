//
//  ExpensesTab.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-28.
//

import SwiftUI

struct ExpensesTab: View {
    @StateObject private var budgetReportViewModel =   BudgetReportViewModel()
    @StateObject private var expensesReportViewModel =   ExpensesReportViewModel()
    @EnvironmentObject var viewModel: AuthViewModel

    @State private var selectedCategory = ""

    var body: some View {
        VStack{
            Text("Expenses Report")
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
                    expensesReportViewModel.generateReport(userId: userId, selectedCategory: selectedCategory)
                }
            }
            .padding(10)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .frame(width: 200)
            
            // Display fetched expenses here
            if !expensesReportViewModel.expenses.isEmpty {
                List(expensesReportViewModel.expenses) { expense in
                    VStack{
                        HStack {
                            Text("Category:")
                            Text(String(expense.category ))
                        }
                        HStack {
                            Text("Amount:")
                            Text(String(expense.amount ))
                        }
                        HStack {
                            Text("Date:")
                            Text(formatDate(expense.date))
                        }
                        HStack {
                            Text("Description:")
                            Text(String(expense.description ))
                        }
                        HStack {
                            Text("Location:")
                            Text(String(expense.location ))
                        }

                    }
                }
                .listStyle(PlainListStyle())
            } else {
                Text("No expenses data found.")
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
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }

}

struct ExpensesTab_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesTab()
    }
}
