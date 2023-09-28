//
//  Category.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-24.
//

import Foundation
import FirebaseFirestoreSwift

struct Category: Identifiable, Codable {
    @DocumentID var id: String?
    let userId: String
    var categoryName: String
}
