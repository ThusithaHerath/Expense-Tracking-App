//
//  AddExpenses.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-23.
//

import SwiftUI


struct AddExpenses: View {
  
    @State private var date = Date()
    @State private var categoryName = ""
    @State private var category = ""
    @State private var amount = ""
    @State private var description = ""
    @State private var location = ""
    //display alert message
    @State private var showAlert = false
    @State private var alertMessage = ""

    
    @EnvironmentObject var viewModel: AuthViewModel
    @StateObject private var categoryViewModel = CategoryViewModel()
    @StateObject private var budgetViewModel = BudgetViewModel()
    @StateObject private var addExpenseViewModel = AddExpenseViewModel()

    
    var formIsValid: Bool {
         return
        !category.isEmpty &&
        !amount.isEmpty &&
        !location.isEmpty &&
        !description.isEmpty
     }
    var categoryFormIsValid: Bool {
         return
        !categoryName.isEmpty
     }
        var body: some View {
            ScrollView{
                VStack() {
                    Text("Add Expenses")
                        .font(.headline)
                        .padding(.top,5)
                    VStack {
                        DatePicker("Date", selection: $date, displayedComponents: .date)
                                      .datePickerStyle(GraphicalDatePickerStyle())
                                      .padding()
                                      .frame(height: 300)
                        
                        HStack {
                               Text("Category")
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
                        TextField("Description", text: $description)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()

                        TextField("Location", text: $location)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()

                        Button("Set Budget") {
                            if let userId = viewModel.userSession?.uid, let budgetAmount = Double(amount)
                            {
                            Task {
                                await addExpenseViewModel.addExpense(for:userId, category:category, amount:budgetAmount, description:description, location:location, date:date)
                                // Reset text field
                                categoryName = ""
                                amount = ""
                                location = ""
                                description = ""
                                                       
                                // Trigger the success alert
                                alertMessage = "Expenses added successfully!"
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
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Success"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
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
}

struct AddExpenses_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenses()
    }
}
