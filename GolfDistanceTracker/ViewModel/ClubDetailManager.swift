//
//  GolfDistanceTrackerVM.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 12/29/23.
//

import CoreData
import Foundation

class ClubDetailManager: ObservableObject {
    
    @Published var notes = ""
    @Published var clubBrand = ""
    @Published var ballBrand = ""
    @Published var carryDistance = 0
    @Published var shaftName = ""
    @Published var flex = "Regular"
    @Published var loft = "N/A"
    @Published var shaftFlexType = ["Regular", "Stiff", "X Stiff", "Senior", "Ladies"]
    @Published var wedgeDegrees = ["N/A", "42°", "44°", "46°", "48°", "50°", "52°", "54°", "56°", "58°", "60°", "62°", "64°"]
    
    
    
   
    
    init() {

    }
    
    
    // MARK: - Save data
    func saveData(context: NSManagedObjectContext) {
        do {
            
            if context.hasChanges {
                try context.save()
            }

        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    


    
    
    // MARK: - load JSON Preload data
    
    @discardableResult func getPreLoadedJSON(_ file: String, context: NSManagedObjectContext,  firstTime: inout Bool) -> [ClubDetailsEntity] {
        //Create a URL
        guard let url = Bundle.main.url(forResource: file, withExtension: "json") else { fatalError("Failed to locate \(file) in bundle")}
        
        guard let data = try? Data(contentsOf: url) else { fatalError("Failed to load \(file) from bundle")}
        
        let decoder = JSONDecoder()
        
        guard let preloadedClubData = try? decoder.decode([ClubResponse].self, from: data) else { fatalError("Failed to decode \(file)")}
        
        
        var preloadedGolfClubs = [ClubDetailsEntity]()
        
        
        if firstTime {
            for loadedClub in preloadedClubData {
                let loadedEntity = ClubDetailsEntity(context: context)
                loadedEntity.name = loadedClub.name
                preloadedGolfClubs.append(loadedEntity)
            }
            
            
            firstTime = false
        }

        return preloadedGolfClubs
    }
}
