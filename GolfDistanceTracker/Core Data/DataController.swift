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
    
    ///Entity Names
    private let entityName = "ClubEntity"
    private let swingTypeEntityName = "SwingTypeEntity"
    private let shotEntityName = "ShotEntity"
    
    
    @Published var savedGolfEntities: [ClubEntity] = []
    
    
    // MARK: - Might need to create new entity arrays for each entity created?
    //Will Delete mark comment if needed
//    @Published var savedSwingTypes: [SwingTypeEntity] = []
//    @Published var savedShots: [ShotEntity] = []
  
    
    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("Core data failed to load \(error.localizedDescription)")
            } else {
                print("Core data successfully loaded")
            }
        }
        
        getClubs()
//        getSwingTypes()
//        getShots()
    }
    
    
    ///Fetching the golf clubs so we can display them
    func getClubs() {
        let request = NSFetchRequest<ClubEntity>(entityName: entityName)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ClubEntity.carryDistance, ascending: false),
                                   NSSortDescriptor(keyPath: \ClubEntity.name, ascending: true)]
        
        do {
            savedGolfEntities = try container.viewContext.fetch(request)
        } catch {
            print("Error retrieving clubs")
        }
    }
    
    // MARK: - Might need to create new functions to fetch request the entities into the array.
    //Save for now and can delete later
    //Will Delete mark comment if needed
//    func getSwingTypes() {
//        let request = NSFetchRequest<SwingTypeEntity>(entityName: swingTypeEntityName)
//        
//        do {
//            savedSwingTypes = try container.viewContext.fetch(request)
//        } catch {
//            print("Error retrieving swing types")
//        
//        }
//   
//    }
    
    
//    func getShots() {
//        let request = NSFetchRequest<ShotEntity>(entityName: shotEntityName)
//        
//        do {
//            savedShots = try container.viewContext.fetch(request)
//        } catch  {
//            print("Error retrieving shots")
//        }
//        
//    }
    
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
    
    ///Creates a new club which will be added to the ClubDetailsEntity array
    ///For example, if I had a 4-Hybrid, this will be added to the list of golf clubs
    ///We are passing in a string because this will allow the user to input what the club type is
    func addClub(club: String) {
        let newClub = ClubEntity(context: container.viewContext)
        newClub.name = club
   
        
        // Predefined swing types
        //Need to predefine the swing types because when the club is added, the swings types are not being displayed
          let swingTypes = [
              "Full Swing",
              "3/4 Swing",
              "Half Swing",
              "Quarter Swing"
          ]

          // Create SwingTypeEntity objects and associate them with the new club
          for swingTypeName in swingTypes {
              let newSwingType = SwingTypeEntity(context: container.viewContext)
              newSwingType.swingType = swingTypeName
              newSwingType.clubdetails = newClub


              // Add the swing type to the club
              newClub.addToSwingTypes(newSwingType)
          }

        saveData()
    }
    

    func addShotDistance(to swingType: SwingTypeEntity, distance: Int, date: Date) {
        ///Need to use if DEBUG which only executes in a developer environment and not in production
#if DEBUG
        print("Adding shot to \(swingType.swingType ?? "Unknown") for club \(swingType.clubdetails?.name ?? "no club")")
#endif
        //Create the a new ShotEntity
        let shot = ShotEntity(context: container.viewContext)
        shot.distance = Int16(distance)
        shot.dateEntered = date
        // Set the relationship between the new shot and the existing swingTyp
        shot.swingTypes = swingType
        swingType.addToShots(shot)


        saveData()
    }
    
    
    func deleteSwing(offsets: IndexSet, from swing: ClubEntity) {
        for i in offsets {
            let input = swing.viewSwingSortedEntities[i]
            container.viewContext.delete(input)
        }
        saveData()
    }
    
    
    func getPreLoadedJSON(_ file: String, firstTime: inout Bool) -> [ClubEntity] {
        //Create a URL
        guard let url = Bundle.main.url(forResource: file, withExtension: "json") else { fatalError("Failed to locate \(file) in bundle")}
        
        guard let data = try? Data(contentsOf: url) else { fatalError("Failed to load \(file) from bundle")}
        
        let decoder = JSONDecoder()
        
        guard let preloadedClubData = try? decoder.decode([ClubResponse].self, from: data) else { fatalError("Failed to decode \(file)")}
        
        var preloadedGolfClubs = [ClubEntity]()
        
        if firstTime {
            for loadedClub in preloadedClubData {
                let loadedEntity = ClubEntity(context: container.viewContext)
                loadedEntity.name = loadedClub.name
                preloadedGolfClubs.append(loadedEntity)
                
                for swing in loadedClub.swingTypes {
                    let loadedSwingTypeEntity = SwingTypeEntity(context: container.viewContext)
                    loadedSwingTypeEntity.swingType = swing
                    loadedEntity.addToSwingTypes(loadedSwingTypeEntity)
                   
                }
            }
            
            saveData()
            firstTime = false
        }
    
        return preloadedGolfClubs
    }
    
}
