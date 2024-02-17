//
//  GolfDistanceTrackerApp.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 8/3/23.
//

import SwiftUI
import TipKit

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
    
    //Loading Tips when the app starts. Best practice is to call this once per app session, such as in the init() method of the app
    init() {
        //Configure and load all tips in the app
        try? Tips.configure([
            .datastoreLocation(.applicationDefault),
            .displayFrequency(.immediate)
        ])
        
    
    }
}
