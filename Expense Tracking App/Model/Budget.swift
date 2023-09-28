//
//  Budget.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-28.
//

import Foundation
import FirebaseFirestoreSwift

struct Budget: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String
    var category: String
    var amount: Double
    var balance: Double
    var Budget_expenses: Double // Assuming this matches your Firestore field name
    var period: Period

    enum Period: String, Codable, CaseIterable {
        case weekly = "Weekly"
        case monthly = "Monthly"
    }

    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case category
        case period
        case amount
        case balance
        case Budget_expenses // Match the Firestore field name here
    }

    init(id: String?, userId: String, category: String, amount: Double, balance: Double, Budget_expenses: Double, period: Period) {
        self.id = id
        self.userId = userId
        self.category = category
        self.amount = amount
        self.balance = balance
        self.Budget_expenses = Budget_expenses
        self.period = period
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.category = try container.decode(String.self, forKey: .category)
        self.period = try container.decode(Period.self, forKey: .period)
        self.amount = try container.decode(Double.self, forKey: .amount)
        self.balance = try container.decode(Double.self, forKey: .balance)
        self.Budget_expenses = try container.decode(Double.self, forKey: .Budget_expenses)
    }
}
