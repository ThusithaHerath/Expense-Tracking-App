//
//  HomeView.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-08-28.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @StateObject private var incomeViewModel = IncomeViewModel()
    
    // Calculate total and angles
    var total: Double {
        (incomeViewModel.userIncome ?? 0) + (incomeViewModel.userExpenses ?? 0) + (incomeViewModel.userBalance ?? 0)
    }

    var incomeAngle: Angle {
        Angle(degrees: 360 * ((incomeViewModel.userIncome ?? 0) / total))
    }

    var expensesAngle: Angle {
        Angle(degrees: 360 * ((incomeViewModel.userExpenses ?? 0) / total))
    }
    
    var body: some View {
            VStack(spacing: 10) {
                Text("Dashboard")
                    .padding(.top,5)
                List{
                    Section(){
                        HStack{
                            LabelCard(imageName: "doc", title: "Income", tintColor: Color(.systemGray),textColor: Color.green)
                                    Spacer()
                                    if let fetchedIncome = incomeViewModel.userIncome {
                                        Text("\(fetchedIncome, specifier: "%.2f")")
                                            .font(.subheadline)
                                            .foregroundColor(.green)
                                    } else {
                                        Text("N/A")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                        }
                    }
                    Section(){
                        HStack{
                            LabelCard(imageName: "doc", title: "Expenses", tintColor: Color(.systemGray),textColor: Color.red)
                            Spacer()
                            
                            if let fetchedExpenses = incomeViewModel.userExpenses {
                                Text("\(fetchedExpenses, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .foregroundColor(.red)
                            } else {
                                Text("N/A")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    Section(){
                        HStack{
                            LabelCard(imageName: "doc", title: "Balance", tintColor: Color(.systemGray),textColor: Color.blue)
                            Spacer()
                            
                            if let fetchedBalance = incomeViewModel.userBalance {
                                Text("\(fetchedBalance, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            } else {
                                Text("N/A")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }

                        }
                    }
                    Section(){
                        ZStack {
                            PieChart(startAngle: .zero, endAngle: incomeAngle, color: .green, label: formatAmount(incomeViewModel.userIncome))
                            PieChart(startAngle: incomeAngle, endAngle: incomeAngle + expensesAngle, color: .red, label: formatAmount(incomeViewModel.userExpenses))
                            PieChart(startAngle: incomeAngle + expensesAngle, endAngle: .degrees(360), color: .blue, label: formatAmount(incomeViewModel.userBalance))
                        }
                        .frame(height: 300)
                        .padding()
                    }
                    
                }
               
            }
            .onAppear {
               if let userId = viewModel.userSession?.uid {
                   print("DEBUG: User ID: \(userId)")
                   Task {
                       await incomeViewModel.fetchIncome(for: userId)
                   }
               } else {
                   print("DEBUG: No user session found.")
               }
            }

        }
}

func formatAmount(_ amount: Double?) -> String {
    guard let amount = amount else {
        return "0.00"
    }
    return String(format: "%.2f", amount)
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
