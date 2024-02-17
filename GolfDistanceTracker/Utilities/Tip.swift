//
//  Tip.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 2/10/24.
//

import Foundation
import TipKit

struct AddClubInfoTip: Tip {
    
    static let didSelectClub = Event(id: "didSelectClub")
    
    var title: Text {
        Text("Input your club info")
            .foregroundStyle(.blue)
    }
    
    var message: Text? {
        Text("Select a club to add information")
    }
    
    var image: Image? {
        Image(systemName: "pencil.and.list.clipboard")
          
    }
    
    
    ///Never clicked on a club to enter info
    var rules: [Rule] {
         
        #Rule(Self.didSelectClub) { info in
            info.donations.count < 1
        }
    }
    
}
