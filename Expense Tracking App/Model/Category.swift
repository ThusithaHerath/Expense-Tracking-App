//
//  Category.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-24.
//

import Foundation

struct Category: Identifiable, Codable {
    let id: String
    let userId: String
    let categoryName: String
}
