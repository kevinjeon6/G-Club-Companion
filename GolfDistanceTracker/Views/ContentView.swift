//
//  ContentView.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 8/3/23.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var golfClub: FetchedResults<ClubDetailsEntity>
    
    var clubType = ["Driver", "3W", "5W", "Hybrid", "2-iron", "3-iron", "4-iron", "5-iron", "6-iron", "7-iron", "8-iron", "9-iron", "PW", "GW", "SW", "LW"]
    
    
    // MARK: - Body
    var body: some View {
        
        //This view only display the data
        NavigationStack {
            List {
                ForEach(golfClub, id: \.self) { club in


                    NavigationLink {
                        ClubDetailsView(clubDetails: club)
                    } label: {
                        ClubDistanceRowView(highestValue: 400, clubName: club.clubBrand ?? "", carryDistance: Int16(club.carryDistance))
        
                    }

                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.listBackgroundColor)
            }
            .listStyle(.plain)
            .environment(\.defaultMinListRowHeight, 50)
            .toolbarBackground(Color.listBackgroundColor, for: .navigationBar)
            .navigationTitle("Club Distance")
            .background(Color.listBackgroundColor)
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
