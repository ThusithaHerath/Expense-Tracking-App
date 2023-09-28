//
//  IncomeTab.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-28.
//

import SwiftUI
import PDFKit

struct IncomeTab: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @StateObject private var incomeReportViewModel = IncomeReportViewModel()
    @State private var pdfDocument: PDFDocument?
    
    
    var body: some View {
        VStack {
            Text("Income Report")
                .font(.title)
                .padding()
            VStack{
                Section{
                    if let userData = incomeReportViewModel.userData {
                        Text("User: \(userData.fullname)")
                            .padding()
                        Text("Email: \(userData.email)")
                            .padding()
                    }
                    
                    if let incomeData = incomeReportViewModel.incomeData {
                        VStack {
                            HStack {
                                Text("Income:")
                                Text(String(format: "%.2f", incomeData.income ))
                            }
                            HStack {
                                Text("Expenses:")
                                Text(String(format: "%.2f", incomeData.expenses))
                            }
                            HStack {
                                Text("Balance:")
                                Text(String(format: "%.2f", incomeData.balance))
                            }

                        }.padding()
                    }
                }
                
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 2)
            )
            .padding()
            
            Button("Download PDF") {
                if let userData = incomeReportViewModel.userData, let incomeData = incomeReportViewModel.incomeData {
                    let pdfInfo = PDFInfo(userData: userData, incomeData: incomeData)
                    let generatedPDF = generatePDF(info: pdfInfo)
                    savePDF(generatedPDF)
                }
            }
            .padding()

            .padding()
        }
        .onAppear {
            if let userId = viewModel.userSession?.uid {
                print("Fetching data for userId: \(userId)")
                incomeReportViewModel.fetchData(for: userId)
            }
        }
    }
    
    private func generatePDF(info: PDFInfo) -> PDFDocument {
        let pdf = PDFDocument()
        
        // Create a page
        let page = PDFPage()
        
        // Create a text box for the report content
        let text = "Income Report\n\n" +
                   "Username: \(info.userData.fullname)\n" +
                   "Email: \(info.userData.email)\n" +
                   "Income: \(String(format: "%.2f", info.incomeData.income))\n" +
                   "Expenses: \(String(format: "%.2f", info.incomeData.expenses))\n" +
                   "Balance: \(String(format: "%.2f", info.incomeData.balance))"
        
        let textBox = PDFAnnotation(bounds: CGRect(x: 50, y: 500, width: 500, height: 200), forType: .freeText, withProperties: nil)
        textBox.contents = text
        page.addAnnotation(textBox)
        
        // Add the page to the PDF document
        pdf.insert(page, at: pdf.pageCount)
        
        return pdf
    }
    
    private func savePDF(_ pdfDocument: PDFDocument?) {
        guard let pdfDocument = pdfDocument else {
            return
        }
        
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let pdfURL = documentsDirectory.appendingPathComponent("IncomeReport.pdf")
            
            do {
                try pdfDocument.write(to: pdfURL)
                print("PDF saved to: \(pdfURL)")
            } catch {
                print("Error saving PDF: \(error.localizedDescription)")
            }
        }
    }

}

struct IncomeTab_Previews: PreviewProvider {
    static var previews: some View {
        IncomeTab()
    }
}
struct PDFInfo {
    let userData: UserData
    let incomeData: IncomeData
}
