//
//  LabelCard.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-14.
//

import SwiftUI

struct LabelCard: View {
    let imageName: String
    let title: String
    let tintColor: Color
    let textColor: Color

    var body: some View {
        HStack(spacing: 15){
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            Text(title)
                .font(.subheadline)
                .foregroundColor(textColor)
            
        }
    }
}

struct LabelCard_Previews: PreviewProvider {
    static var previews: some View {
        LabelCard(imageName: "gear", title: "Version", tintColor: Color(.systemGray), textColor: Color(.systemGray))

    }
}
