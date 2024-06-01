//
//  GolfDistanceTrackerVM.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 12/29/23.
//

import Foundation

class ClubDetailManager: ObservableObject {
    
    @Published var name = ""
    @Published var notes = ""
    @Published var clubBrand = ""
    @Published var ballBrand = ""
    @Published var carryDistance = 0
    @Published var shaftName = ""
    @Published var flex = "Regular"
    @Published var loft = "N/A"
    @Published var shaftFlexType = ["Regular", "Stiff", "X Stiff", "Senior", "Ladies"]
    @Published var wedgeDegrees = ["N/A", "42°", "44°", "46°", "48°", "50°", "52°", "54°", "56°", "58°", "60°", "62°", "64°"]

}
