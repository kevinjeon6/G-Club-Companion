//
//  ContentView.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 8/3/23.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            Text("Clubs and distance")
                .navigationTitle("Club Distance")
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
