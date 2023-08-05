//
//  ClubDistanceRowView.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 8/4/23.
//

import SwiftUI


struct ClubDistanceRowView: View {
    
    // MARK: - Properties
    let value: Int
    let highestValue: Int
    let color1: Color = .leadingGreenColor
    let color2: Color = .trailingGreenColor
    
    
    // MARK: - Body
    var body: some View {
        
        GeometryReader { geo in
            VStack {
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black.opacity(0.1))
                        .frame(height: 40)
                    
                    LinearGradient(gradient: Gradient(colors: [color1, color2]), startPoint: .leading, endPoint: .trailing)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: geo.size.width * CGFloat(value) / CGFloat(highestValue))
                    
                    HStack {
                        Text("Driver")
                        Spacer()
                        Text("225 yds")
                    }
                    .font(.system(size: 26, weight: .semibold, design: .rounded))
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                  
                }
            }
            .frame(width: geo.size.width * 0.8, height: 40)
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

struct ClubDistanceRowView_Previews: PreviewProvider {
    static var previews: some View {
        ClubDistanceRowView(value: 247, highestValue: 247)
    }
}
