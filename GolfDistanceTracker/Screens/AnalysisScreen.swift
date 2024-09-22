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


// MARK: - Relationships
extension ClubEntity {
    
    var viewSwingSortedEntities: [SwingTypeEntity] {
        //Convert NSOrderedSet to array

        ///Need to make the To Many relationship arrangement property to Ordered. If not, the ForEach will display the JSON data (swingTypes array) in a random order
        let swings = swingTypes?.array as? [SwingTypeEntity] ?? []
        
        ///Static order will make it displayed correctly. Not using a static order will randomize the swing types under the golf club in Shot Analysis tab
        let staticOrder = [
            "Full Swing",
            "3/4 Swing",
            "Half Swing",
            "Quarter Swing"
        ]
        
        ///Keys would be the array of strings. Values are the index
        let staticMap = Dictionary(uniqueKeysWithValues: staticOrder.enumerated().map { ($1, $0) })

        return swings.sorted {
            let order1 = staticMap[$0.swingType ?? ""] ?? Int.max
            let order2 = staticMap[$1.swingType ?? ""] ?? Int.max
            return order1 < order2
        }
    }
}
