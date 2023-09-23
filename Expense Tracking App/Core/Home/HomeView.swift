//
//  HomeView.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-08-28.
//

import SwiftUI

struct HomeView: View {
    let income: Double = 500.00
    let expenses: Double = 300.00
    let balance: Double = 200.00
    @EnvironmentObject var viewModel: AuthViewModel
    
    // Calculate total and angles
    var total: Double {
        income + expenses + balance
    }

    var incomeAngle: Angle {
        Angle(degrees: 360 * (income / total))
    }

    var expensesAngle: Angle {
        Angle(degrees: 360 * (expenses / total))
    }
    
    var body: some View {
        if let user = viewModel.currentUser{
            VStack(spacing: 10){
                Text("Dashboard")
                    .padding(.top,5)
                List{
                    Section(){
                        HStack{
                            LabelCard(imageName: "doc", title: "Income", tintColor: Color(.systemGray),textColor: Color.green)
                            Spacer()
                            
                            Text("100.00")
                                .font(.subheadline)
                                .foregroundColor(.green)
                        }
                    }
                    Section(){
                        HStack{
                            LabelCard(imageName: "doc", title: "Expenses", tintColor: Color(.systemGray),textColor: Color.red)
                            Spacer()
                            
                            Text("100.00")
                                .font(.subheadline)
                                .foregroundColor(.red)
                        }
                    }
                    Section(){
                        HStack{
                            LabelCard(imageName: "doc", title: "Balance", tintColor: Color(.systemGray),textColor: Color.blue)
                            Spacer()
                            
                            Text("100.00")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                    Section(){
                        ZStack {
                            PieChart(startAngle: .zero, endAngle: incomeAngle, color: .green, label: "Income:\(income)")
                            PieChart(startAngle: incomeAngle, endAngle: incomeAngle + expensesAngle, color: .red, label: "Expenses: ")
                            PieChart(startAngle: incomeAngle + expensesAngle, endAngle: .degrees(360), color: .blue, label: "Balance:")
                        }
                        .frame(height: 300)
                        .padding()
                    }
                    
                }
               
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
