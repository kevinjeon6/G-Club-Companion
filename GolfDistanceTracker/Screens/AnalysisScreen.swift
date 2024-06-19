//
//  AnalysisScreen.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 6/6/24.
//

import SwiftUI

struct AnalysisScreen: View {
    @EnvironmentObject var moc: DataController
    
    var body: some View {
        NavigationStack {
            List(moc.savedGolfEntities) {
                swing in
                Section {
                    ForEach(swing.viewSwingEntitiesSorted) { item in
                        HStack {
                            Text(item.swingType ?? "no type")
                            Spacer()
                            Text("\(item.value)")
                        }
                    }
                } header: {
                    Text(swing.name ?? "n/a")
                }
            }
            .navigationTitle("Nested")
        }
    }
}



#Preview {
    AnalysisScreen()
        .environmentObject(DataController())
}


extension ClubDetailsEntity {
    
    var viewSwingEntitiesSorted: [SwingTypeEntity] {
        //Convert NSOrderedSet to array
        let swings = swingEntities?.array as? [SwingTypeEntity] ?? []
        
        let staticOrder = ["Full Swing", "3/4 Swing", "Half Swing", "Quarter Swing"]
        
        ///Keys would be the array of strings. Values are the index
        let staticMap = Dictionary(uniqueKeysWithValues: staticOrder.enumerated().map { ($1, $0) })


        return swings.sorted {
            let order1 = staticMap[$0.swingType ?? ""] ?? Int.max
            let order2 = staticMap[$1.swingType ?? ""] ?? Int.max
            return order1 < order2
        }
    }
}
