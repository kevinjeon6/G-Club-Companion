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
            List {
                ForEach(moc.savedGolfEntities) { swing in
                    Section {
                        ForEach(swing.viewSwingEntitiesSorted) {
                            shot in
                            NavigationLink {
                                ShotHistoryScreen(selectedSwingType: shot)
                            } label: {
                                Text(shot.swingNameType ?? "N/A")
                            }
                        }
                    } header: {
                        Text(swing.name ?? "n/a")
                    }
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


extension ClubDetailsEntity {
    
    var viewSwingEntitiesSorted: [SwingTypeEntity] {
        //Convert NSOrderedSet to array

        ///Need to make the To Many relationship arrangement property to Ordered. If not, the ForEach will display the JSON data (swingTypes array) in a random order
        let swings = swingEntities?.array as? [SwingTypeEntity] ?? []
        
        let staticOrder = [
            "Full Swing",
            "3/4 Swing",
            "Half Swing",
            "Quarter Swing"
        ]
        
        ///Keys would be the array of strings. Values are the index
        let staticMap = Dictionary(uniqueKeysWithValues: staticOrder.enumerated().map { ($1, $0) })


        return swings.sorted {
            let order1 = staticMap[$0.swingNameType ?? ""] ?? Int.max
            let order2 = staticMap[$1.swingNameType ?? ""] ?? Int.max
            return order1 < order2
        }
    }
}
