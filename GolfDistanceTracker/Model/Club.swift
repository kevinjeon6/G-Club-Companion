//
//  Club.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 8/29/23.
//

import Foundation

/*
 Need to preload the swing types (Full, 3/4, Half, Quarter) for each of the preloaded clubs because if there isn't the preloaded swing types, then in the Shot Analysis tab, the swing types are not displayed under the golf club
 */

//Model for JSON data
struct ClubResponse: Codable, Hashable {
    let name: String
    let swingTypes: [String]
}



