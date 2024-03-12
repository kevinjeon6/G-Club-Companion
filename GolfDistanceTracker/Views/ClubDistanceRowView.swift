//
//  ClubDistanceRowView.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 8/4/23.
//

import SwiftUI


struct ClubDistanceRowView: View {
    
    // MARK: - Properties
    let clubName: String
    var carryDistance: Int16
    
    
    // MARK: - Body
    var body: some View {
        
        HStack {
            ZStack(alignment: .leading) {
                CarryDistanceGaugeView(inputValue: Int(carryDistance))
                
                    Text(clubName)
                        .padding(.leading)
        
            }
            .font(.system(.title, design: .rounded)) ///title is gives size of 25
            .fontWeight(.semibold)
            .foregroundColor(.primary)
            Spacer()
            Text("\(carryDistance)")
                .font(.system(.title2, design: .rounded)) ///title2 gives size of 19
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
            
            
        }
        .padding(.trailing)
        
    }
}


struct ClubDistanceRowView_Previews: PreviewProvider {
    static var previews: some View {
        ClubDistanceRowView(clubName: "Driver", carryDistance: 69)
    }
}
