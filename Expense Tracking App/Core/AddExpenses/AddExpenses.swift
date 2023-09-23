//
//  AddExpenses.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-23.
//

import SwiftUI


struct AddExpenses: View {
     @Binding var expenses: [Expense]

     @State private var date = Date()
     @State private var category = ""
     @State private var amount = ""
     @State private var description = ""
     @State private var location = ""
 
    var body: some View {
        VStack() {
                    Text("Add New Expense")
                        .font(.headline)
                        .padding(.top, 30)

                    DatePicker("Date", selection: $date, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()

                    TextField("Category", text: $category)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
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
                    Button("Add Expense") {
                           let newExpense = Expense(id: UUID(), date: date, category: category, amount: Double(amount) ?? 0.0, description: description, location: location)
                           expenses.append(newExpense)

                           date = Date()
                           category = ""
                           amount = ""
                           description = ""
                           location = ""
                       }
                       .padding(10)
                       .background(Color.blue)
                       .foregroundColor(.white)
                       .cornerRadius(8)
                       .frame(width: 200)
                   }
                   .padding()

    }
}

struct AddExpenses_Previews: PreviewProvider {
    @State static var dummyExpenses: [Expense] = []
    static var previews: some View {
        AddExpenses(expenses: $dummyExpenses)    }
}
struct Expense: Identifiable {
    let id: UUID
    var date: Date
    var category: String
    var amount: Double
    var description: String
    var location: String
}
