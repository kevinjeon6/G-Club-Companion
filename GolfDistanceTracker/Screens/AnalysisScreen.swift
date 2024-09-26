//
//  AnalysisScreen.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 6/6/24.
//

import SwiftUI

struct AnalysisScreen: View {
    @EnvironmentObject var moc: DataController
    @EnvironmentObject var clubManager: ClubDetailManager
    
    var body: some View {
        NavigationStack {
            List(moc.savedGolfEntities) { swing in
                    Section {
                        ForEach(swing.viewSwingSortedEntities) {
                            shot in
                            NavigationLink {
                                ShotHistoryScreen(selectedSwingType: shot)
                            } label: {
                                Text(shot.swingType ?? "N/A")
                            }
                        }
                    } header: {
                        Text(swing.name ?? "n/a")                    
                .headerProminence(.increased)
                }
            }
            .navigationTitle("Nested")
        }
    }
}



#Preview {
    AnalysisScreen()
        .environmentObject(DataController())
        .environmentObject(ClubDetailManager())
}



