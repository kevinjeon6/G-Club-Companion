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
    let width: CGFloat = 250
    let color1: Color = .leadingGreenColor
    let color2: Color = .trailingGreenColor
    let clubName: String
    
    
    
    // MARK: - Body
    var body: some View {
        
        HStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.black.opacity(0.1))
                    .frame(width: width, height: 40)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: width * CGFloat(value) / CGFloat(highestValue), height: 40)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [color1, color2]), startPoint: .leading, endPoint: .trailing)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    )
                    .foregroundColor(.clear)
                
                Text(clubName)
                    .padding(.leading)
                
            }
            .font(.system(size: 26, weight: .semibold, design: .rounded))
            .foregroundColor(.primary)
            Spacer()
            Text("123")
            
        }
        .padding(.trailing)
        
    }
}


struct ClubDistanceRowView_Previews: PreviewProvider {
    static var previews: some View {
        ClubDistanceRowView(value: 150, highestValue: 225, clubName: "Driver")
    }
}
