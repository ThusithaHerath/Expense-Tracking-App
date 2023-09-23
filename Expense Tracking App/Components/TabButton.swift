//
//  TabButton.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-08-29.
//

import SwiftUI

struct TabButton: View {
    let title: String
    let image: String
    var body: some View {
        Button{
            
        } label: {
            HStack(spacing: 14){
                Image(image)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                Text(title)
            }
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        TabButton(title: "hi", image: "image")
    }
}
