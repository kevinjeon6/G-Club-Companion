//
//  GaugeView.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 3/3/24.
//

import SwiftUI

struct CarryDistanceGaugeView: View {
    
    var inputValue: Int
    let minValue = 0.0
    let maxValue = 500.0
    let gradient = Gradient(colors: [.leadingGreenColor, .trailingGreenColor])
    
    var body: some View {
        Gauge(value: Double(inputValue), in: minValue...maxValue) {
            EmptyView()
        }
        .scaleEffect(CGSize(width: 1.0, height: 2.5))
        .tint(gradient)
    }
}

#Preview {
    CarryDistanceGaugeView(inputValue: 250)
}
