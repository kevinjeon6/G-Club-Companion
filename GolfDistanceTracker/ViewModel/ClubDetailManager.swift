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
    @Published var clubBrandName = ""
    @Published var ballBrand = ""
    @Published var carryDistance = 0
    @Published var shaftName = ""
    @Published var loftValue = 0.0
    @Published var flex = "Regular"
    @Published var flexOption = ["Regular", "Stiff", "X Stiff", "Senior", "Ladies"]
    @Published var date = Date()

}
