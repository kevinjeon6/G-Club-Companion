//
//  ClubsView.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 8/3/23.
//

import SwiftUI
import TipKit

struct ClubsView: View {
    
    // MARK: - Properties
    @EnvironmentObject var moc: DataController
    @State private var isShowingClubSheet = false
    
    ///This is the first time the user opened the app and loaded the data. Then any launches after this will set it to false
    @AppStorage("isFirstTimeLoaded") private var isFirstTimeLoaded = true
    
    ///Inline Tip View
    private let inputTip = AddClubInfoTip()

    // MARK: - Body
    var body: some View {
        NavigationStack {
            List{
                TipView(inputTip)
                    .listRowBackground(Color.listBackgroundColor)
                    .tipBackground(.ultraThinMaterial)

                ///Don't need id for list. Core Data automatically makes the entities conform to Identifiable
                ForEach(moc.savedGolfEntities) { club in
                    NavigationLink {
                        ClubDetailsView(clubDetails: club)
                    } label: {
                        ClubDistanceRowView(clubName: club.name ?? "", carryDistance: club.carryDistance)
                    }
                }
                .onDelete(perform: moc.deleteClub )
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
                moc.getPreLoadedJSON("preLoadedData", firstTime: &isFirstTimeLoaded)
            }
        }
    }
}

struct ClubsView_Previews: PreviewProvider {
    static var previews: some View {
        ClubsView()
            .environmentObject(DataController())
            .task {
                try? Tips.configure([
                    .datastoreLocation(.applicationDefault),
                    .displayFrequency(.immediate)
                ])
            }
    }
}
