//
//  AddBudget.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-23.
//

import SwiftUI

struct AddBudget: View {
    @Binding var budgets: [Budget]

    @State private var categoryName = ""
    @State private var category = ""
    @State private var amount = ""
    @State private var income = ""
    @State private var period = Budget.Period.weekly
    //display alert message
    @State private var showAlert = false
    @State private var alertMessage = ""

    
    @EnvironmentObject var viewModel: AuthViewModel
    @StateObject private var categoryViewModel = CategoryViewModel()
    @StateObject private var budgetViewModel = BudgetViewModel()
    @StateObject private var incomeViewModel = IncomeViewModel()

    
    var formIsValid: Bool {
         return
             !category.isEmpty &&
             !amount.isEmpty
     }
    var categoryFormIsValid: Bool {
         return
        !categoryName.isEmpty
     }
    var incomeFromIsValid: Bool {
        return !income.isEmpty
    }
        var body: some View {
            ScrollView {
                Group {
                    VStack{
                        Text("Add your income")
                            .font(.headline)

                        TextField("Income (e.g., 200000.00)", text: $income)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button("Add income") {
                            if let userId = viewModel.userSession?.uid,let incomeAmount = Double(income) {
                                Task {
                                    await incomeViewModel.addIncome(for: userId, income: incomeAmount)
                                    // Reset text fieldt
                                    income = ""
                                    
                                    // Trigger the success alert
                                    alertMessage = "Income added successfully!"
                                    showAlert = true
                                }
                            }
                        }
                        .padding(10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .frame(width: 200)
                        .disabled(!incomeFromIsValid)
                        .opacity(incomeFromIsValid ? 1.0 : 0.5)
                        
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Success"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
                .padding()
                
                Divider().padding(.horizontal)
           
                
                Group{
                    VStack{
                        Text("Add new category")
                            .font(.headline)

                        TextField("Category (e.g., Groceries)", text: $categoryName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button("Add category") {
                            if let userId = viewModel.userSession?.uid {
                                let currentCategoryName = categoryName
                                Task {
                                    await categoryViewModel.addCategory(for: userId, categoryName: categoryName)
                                    // Reset text field
                                    categoryName = ""
                                    
                                    // Trigger the success alert
                                    alertMessage = "Category \(currentCategoryName) added successfully!"
                                    showAlert = true
                                }
                            }
                        }
                        .padding(10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .frame(width: 200)
                        .disabled(!categoryFormIsValid)
                        .opacity(categoryFormIsValid ? 1.0 : 0.5)
                        
                    }
                    .padding()
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Success"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
                
                Divider().padding(.horizontal)
                
                Group{
                    VStack {
                        Text("Set your budget")
                            .font(.headline)
                        
                        HStack {
                               Text("Select Category")
                                  .frame(width: 100, alignment: .leading)
                            
                               Picker("Category", selection: $category) {
                                   ForEach(categoryViewModel.categories, id: \.self) { categoryName in
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


                        TextField("Amount", text: $amount)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .padding()
                        
                        Picker("Period", selection: $period) {
                                ForEach(Budget.Period.allCases, id: \.self) { period in
                                Text(period.rawValue).tag(period)
                              }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding()

                        Button("Set Budget") {
                            if let userId = viewModel.userSession?.uid, let budgetAmount = Double(amount) {
                            Task {
                                let errorMessage = await budgetViewModel.addBudget(for: userId, category: category, amount: budgetAmount, period: period)
                                           if let error = errorMessage {
                                               // Show error message
                                               alertMessage = error
                                           } else {
                                               // Reset text field and show success message
                                               amount = ""
                                               alertMessage = "Budget added successfully!"
                                           }
                                           showAlert = true
                                }
                            }
                        }
                        .padding(10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .frame(width: 200)
                        .disabled(!formIsValid)
                        .opacity(formIsValid ? 1.0 : 0.5)
                        }
                        .padding()
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Success"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
                    }
                }
                
            
            .onAppear {
               if let userId = viewModel.userSession?.uid {
                Task {
                    await categoryViewModel.fetchCategories(for: userId)
                 }
              }
          }
        }

}


struct AddBudget_Previews: PreviewProvider {
    @State static var dummyBudget: [Budget] = []
    static var previews: some View {
        AddBudget(budgets: $dummyBudget)
    }
}

