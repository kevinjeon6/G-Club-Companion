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
    
    
    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("Core data failed to load \(error.localizedDescription)")
            } else {
                print("Core dta successfully loaded")
            }
        }
    }
    
    
}
