//
//  ReportView.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-28.
//

import SwiftUI

struct ReportView: View {
    @State private var selectedTab: Tab = .income
    enum Tab: String, CaseIterable {
        case income = "Income"
        case category = "Category"
        case budget = "Budget"
        case expenses = "Expenses"
    }

    var body: some View {
        NavigationView {
                   VStack {
                       Text("Reports")
                           .font(.headline)
                           .padding(.top, 10)

                       ScrollView(.horizontal, showsIndicators: false) {
                           HStack(spacing: 20) {
                               ForEach(Tab.allCases, id: \.self) { tab in
                                   TabButton2(title: tab.rawValue, isSelected: selectedTab == tab) {
                                       selectedTab = tab
                                   }
                               }
                           }
                           .padding(.horizontal, 16)
                       }
                       .padding(.top, 16)

                       TabView(selection: $selectedTab) {
                           IncomeTab()
                               .tag(Tab.income)
                           CategoryTab()
                               .tag(Tab.category)
                           BudgetTab()
                               .tag(Tab.budget)
                           ExpensesTab()
                               .tag(Tab.expenses)
                       }
                       .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                       .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                   }
                   .navigationBarTitle("", displayMode: .inline)
                   .navigationBarHidden(true)
               }

        
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
