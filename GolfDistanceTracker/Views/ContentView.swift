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
    @FetchRequest<ClubDetailsEntity>(sortDescriptors: [SortDescriptor(\.name)]) private var golfClub

    
    //This is the first time the user opened the app and loaded the data. Then any launches after this will set it to false
    @AppStorage("isFirstTimeLoaded") private var isFirstTimeLoaded = true
    

    private func getPreLoadedJSON(_ file: String, firstTime: inout Bool) -> [ClubDetailsEntity] {
       //Create a URL
       guard let url = Bundle.main.url(forResource: file, withExtension: "json") else { fatalError("Failed to locate \(file) in bundle")}
       
       guard let data = try? Data(contentsOf: url) else { fatalError("Failed to load \(file) from bundle")}
       
       let decoder = JSONDecoder()
       
       guard let preloadedClubData = try? decoder.decode([ClubResponse].self, from: data) else { fatalError("Failed to decode \(file)")}
       
       
       var preloadedGolfClubs = [ClubDetailsEntity]()
       
       if firstTime {
           for loadedClub in preloadedClubData {
               let loadedEntity = ClubDetailsEntity(context: moc)
               loadedEntity.name = loadedClub.name
               
               preloadedGolfClubs.append(loadedEntity)
           }
//            try? moc.save()
           firstTime = false
       }
       
       return preloadedGolfClubs
   }
    
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
                getPreLoadedJSON("preLoadedData", firstTime: &isFirstTimeLoaded)
    
            }
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
