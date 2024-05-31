//
//  AddClubView.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 5/31/24.
//

import SwiftUI

struct AddClubView: View {
    
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: ClubDetailManager
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Club Name", text: $vm.name)
                    .focused($isFocused)
                    .onAppear{
                        UITextField.appearance().clearButtonMode = .always
                    }
                
                Section {
                    Button("Save") {
                        let newClub = ClubDetailsEntity(context: moc)
                        newClub.name = vm.name
                        vm.saveData(context: moc)
                        
                        dismiss()
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
        .environmentObject(ClubDetailManager())
}
