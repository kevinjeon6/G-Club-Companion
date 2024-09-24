//
//  AddClubView.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 5/31/24.
//

import SwiftUI

struct AddClubView: View {
    
    // MARK: - Properties
    @EnvironmentObject var moc: DataController
    @EnvironmentObject var clubManager: ClubDetailManager
    @Environment(\.dismiss) var dismiss
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Club Name", text: $clubManager.name)
                    .focused($isFocused)
                    .onAppear{
                        UITextField.appearance().clearButtonMode = .always
                    }
                
                Section {
                    Button("Save") {
                        moc.addClub(club: clubManager.name)
                        
                        dismiss()
                        ///Clears the TextField so if the user tries to add a new club. It won't display what was previously added.
                        clubManager.name = ""
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                }
                .listRowBackground(Color.blue)
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Club")
        }
    }
}

#Preview {
    AddClubView()
        .environmentObject(DataController())
        .environmentObject(ClubDetailManager())
}
