//
//  ContentView.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 8/3/23.
//

import SwiftUI
import TipKit

struct ContentView: View {
    
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest<ClubDetailsEntity>(sortDescriptors: [SortDescriptor(\.carryDistance, order: .reverse), SortDescriptor(\.name)]) private var golfClub
    @EnvironmentObject var vm: ClubDetailManager
    
    @State private var isShowingClubSheet = false
    
    ///This is the first time the user opened the app and loaded the data. Then any launches after this will set it to false
    @AppStorage("isFirstTimeLoaded") private var isFirstTimeLoaded = true
    
    //Inline Tip View
    private let inputTip = AddClubInfoTip()

    // MARK: - Body
    var body: some View {
        
        ///This view only display the data
        NavigationStack {
            List{
                TipView(inputTip)
                    .listRowBackground(Color.listBackgroundColor)
                    .tipBackground(.ultraThinMaterial)

                ///Don't need id for list. Core Data automatically makes the entities conform to Identifiable
                ForEach(golfClub) { club in
                    NavigationLink {
                        ClubDetailsView(clubDetails: club)
                    } label: {
                        ClubDistanceRowView(clubName: club.name ?? "", carryDistance: club.carryDistance)
                    }
                }
                .onDelete(perform: deleteitem )
                .listRowSeparator(.hidden)
                .listRowBackground(Color.listBackgroundColor)
            }
            .listStyle(.plain)
            .environment(\.defaultMinListRowHeight, 50)
            .toolbarBackground(Color.listBackgroundColor, for: .navigationBar)
            .navigationTitle("Club Distance")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        isShowingClubSheet.toggle()
                    }  label: {
                        Label("Add Club", systemImage: "plus")
                    }
                    .sheet(isPresented: $isShowingClubSheet, content: {
                        AddClubView()
                    })
                }
            }
            .background(Color.listBackgroundColor)
            .onAppear {
             vm.getPreLoadedJSON("preLoadedData", context: moc, firstTime: &isFirstTimeLoaded)
            }
        }
    }
    
    private func deleteitem(offsets: IndexSet) {
        for offset in offsets {
            moc.delete(golfClub[offset])
        }
        
         vm.saveData(context: moc)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .task {
                try? Tips.configure([
                    .datastoreLocation(.applicationDefault),
                    .displayFrequency(.immediate)
                ])
            }
    }
}
