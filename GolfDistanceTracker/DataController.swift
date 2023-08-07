//
//  DataController.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 8/6/23.
//

import CoreData
import SwiftUI


class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "Golf_Distance_Tracker")
    private let entityName = "ClubDetailsEntity"
    
}
