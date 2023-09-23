//
//  Report.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-23.
//

import SwiftUI

struct Report: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Report_Previews: PreviewProvider {
    static var previews: some View {
        Report()
    }
}

struct Analytics {
    var totalSpendingPerCategory: [String: Double]
    var monthlyIncome: [String: Double]
    var budgetAdherence: [(category: String, spent: Double, budgeted: Double)]
}
