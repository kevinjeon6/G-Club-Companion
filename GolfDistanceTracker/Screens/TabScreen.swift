//
//  TabScreen.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 6/6/24.
//

import SwiftUI

struct TabScreen: View {
    
    @EnvironmentObject var moc: DataController
    @EnvironmentObject var clubManager: ClubDetailManager
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            ClubsView()
                .tabItem {
                    Label("Clubs", systemImage: "figure.golf")
                }.tag(1)
            
            AddCarryDistanceScreen()
                .tabItem {
                    Label("Add Distance", systemImage: "plus.circle.fill")
                }.tag(2)
            
            AnalysisScreen()
                .tabItem {
                    Label("Shot Analysis", systemImage: "list.bullet.rectangle.portrait.fill")
                }.tag(3)
        }
    }
}

#Preview {
    TabScreen()
        .environmentObject(DataController())
        .environmentObject(ClubDetailManager())
}
