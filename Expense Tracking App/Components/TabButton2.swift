//
//  TabButton2.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-28.
//

import SwiftUI

struct TabButton2: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
                    Text(title)
                .font(.caption)
                        .foregroundColor(isSelected ? .blue : .gray)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(isSelected ? Color.green.opacity(0.2) : Color.clear)
                        .cornerRadius(8)
        }
        
    }
}

struct TabButton2_Previews: PreviewProvider {
    static var previews: some View {
        TabButton2(title: "hi", isSelected: false) {
            
        }
    }
}
