//
//  AddBudget.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-23.
//

import SwiftUI

struct AddBudget: View {
    @Binding var budgets: [Budget]

        @State private var category = ""
        @State private var amount = ""
        @State private var period = Budget.Period.weekly

        var body: some View {
            VStack(spacing: 20) {
                Text("Set Your Budget")
                    .font(.headline)

                TextField("Category (e.g., Groceries)", text: $category)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
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
                                if let budgetAmount = Double(amount) {
                                    let newBudget = Budget(id: UUID(), category: category, amount: budgetAmount, period: period)
                                    budgets.append(newBudget)

                                    // Reset fields
                                    category = ""
                                    amount = ""
                                }
                            }
                            .padding()
                                       .background(Color.blue)
                                       .foregroundColor(.white)
                                       .cornerRadius(8)
                                   }
                                   .padding()
                               }
}

struct AddBudget_Previews: PreviewProvider {
    @State static var dummyBudget: [Budget] = []
    static var previews: some View {
        AddBudget(budgets: $dummyBudget)
    }
}

struct Budget: Identifiable {
    let id: UUID
    var category: String
    var amount: Double
    var period: Period

    enum Period: String, CaseIterable {
        case weekly = "Weekly"
        case monthly = "Monthly"
    }
}
