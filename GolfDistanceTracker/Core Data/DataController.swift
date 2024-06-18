//
//  DataController.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 8/6/23.
//

import CoreData
import SwiftUI


class DataController: ObservableObject {
    
    //Set up container
    let container = NSPersistentContainer(name: "Golf_Distance_Tracker")
    private let entityName = "ClubDetailsEntity"
    
    @Published var savedGolfEntities: [ClubDetailsEntity] = []
    @Published var driver: ClubDetailsEntity?
    
    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("Core data failed to load \(error.localizedDescription)")
            } else {
                print("Core data successfully loaded")
            }
        }
        
        getClubs()
    }
    
    func getClubs() {
        let request = NSFetchRequest<ClubDetailsEntity>(entityName: entityName)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ClubDetailsEntity.carryDistance, ascending: false),
                                   NSSortDescriptor(keyPath: \ClubDetailsEntity.name, ascending: true)]
        
        do {
            savedGolfEntities = try container.viewContext.fetch(request)
        } catch {
            print("Error retrieving clubs")
        }
    }
    
    func saveData() {
        do {
            if container.viewContext.hasChanges {
                try container.viewContext.save()
                getClubs()
            }
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
   func deleteClub(offsets: IndexSet) {
       offsets.map{ savedGolfEntities[$0] }.forEach(container.viewContext.delete)
       saveData()
    }
    
    
    func addClub(club: String) {
        let newClub = ClubDetailsEntity(context: container.viewContext)
        newClub.name = club
        saveData()
    }
    
    
    func getPreLoadedJSON(_ file: String, firstTime: inout Bool) -> [ClubDetailsEntity] {
        //Create a URL
        guard let url = Bundle.main.url(forResource: file, withExtension: "json") else { fatalError("Failed to locate \(file) in bundle")}
        
        guard let data = try? Data(contentsOf: url) else { fatalError("Failed to load \(file) from bundle")}
        
        let decoder = JSONDecoder()
        
        guard let preloadedClubData = try? decoder.decode([ClubResponse].self, from: data) else { fatalError("Failed to decode \(file)")}
        
        var preloadedGolfClubs = [ClubDetailsEntity]()
        
        if firstTime {
            for loadedClub in preloadedClubData {
                let loadedEntity = ClubDetailsEntity(context: container.viewContext)
                loadedEntity.name = loadedClub.name
                preloadedGolfClubs.append(loadedEntity)
            }
            
            saveData()
            firstTime = false
        }
        return preloadedGolfClubs
    }
    
}
