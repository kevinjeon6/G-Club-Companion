//
//  ContentView.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 8/3/23.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest<ClubDetailsEntity>(sortDescriptors: [SortDescriptor(\.name)]) private var golfClub
    @EnvironmentObject var vm: ClubDetailManager
    
    //This is the first time the user opened the app and loaded the data. Then any launches after this will set it to false
    @AppStorage("isFirstTimeLoaded") private var isFirstTimeLoaded = true
    

    // MARK: - Body
    var body: some View {
        
        //This view only display the data
        NavigationStack {
            List {
                ForEach(golfClub, id: \.self) { club in
                    NavigationLink {
                        ClubDetailsView(clubDetails: club)
                    } label: {
                        ClubDistanceRowView(highestValue: 500, clubName: club.name ?? "", carryDistance: club.carryDistance)
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
            .onAppear {
             vm.getPreLoadedJSON("preLoadedData", context: moc, firstTime: &isFirstTimeLoaded)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
