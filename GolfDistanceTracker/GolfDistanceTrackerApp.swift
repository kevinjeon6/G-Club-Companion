//
//  GolfDistanceTrackerApp.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 8/3/23.
//

import SwiftUI

@main
struct GolfDistanceTrackerApp: App {
    
    @StateObject private var dataController = DataController()
    @StateObject var clubDetailManager = ClubDetailManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(clubDetailManager)
        }
    }
}
