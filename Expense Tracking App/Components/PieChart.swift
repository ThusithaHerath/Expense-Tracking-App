//
//  PieChart.swift
//  Expense Tracking App
//
//  Created by Thusitha Lakshan Herath on 2023-09-23.
//

import SwiftUI
import Charts


struct PieChart: View {
       var startAngle: Angle
       var endAngle: Angle
       var color: Color
       var label: String

    var body: some View {
        GeometryReader { geometry in
                    ZStack {
                        Path { path in
                                          let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                                          path.move(to: center)
                                          path.addArc(center: center, radius: geometry.size.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                                      }
                                      .fill(color)
                        
                        // Position the label
                        Text(label)
                            .position(
                                x: geometry.size.width / 2 + CGFloat(cos((startAngle + (endAngle - startAngle) / 2).radians) * 0.6 * Double(geometry.size.width) / 2),
                                y: geometry.size.height / 2 + CGFloat(sin((startAngle + (endAngle - startAngle) / 2).radians) * 0.6 * Double(geometry.size.height) / 2)
                            )
                    }
                }
    }
}

struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        PieChart(startAngle: Angle(degrees: 360 * (200 / 300)), endAngle: Angle(degrees: 360 * (200 / 300)), color: .black, label: "hi")
    }
}
