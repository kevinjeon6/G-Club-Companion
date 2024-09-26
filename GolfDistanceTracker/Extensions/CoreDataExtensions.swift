//
//  CoreDataExtensions.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 9/26/24.
//

import Foundation


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



// MARK: - Ordering the shots that are entered. Putting the most recent at the top of a List
extension SwingTypeEntity {
    ///Converting the NSSet to array of ShotEntity
    var shotArray: [ShotEntity] {
        let shot = shots?.array as? [ShotEntity] ?? []
        
        return shot.sorted {$0.dateEntered ?? Date() > $1.dateEntered ?? Date()}
    }
}
