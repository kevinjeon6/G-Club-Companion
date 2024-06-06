//
//  AddCarryDistanceScreen.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 6/6/24.
//

import SwiftUI

struct AddCarryDistanceScreen: View {
    // MARK: - Properties
    @EnvironmentObject var moc: DataController
    @EnvironmentObject var clubManager: ClubDetailManager
    
    @FocusState var isFocused: Bool
    
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Club")
                            .font(.title2.bold())
                        Text("Select your club")
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                    }
                    Spacer()
                    
                    Picker("Club", selection: $moc.savedGolfEntities) {
                        ForEach(moc.savedGolfEntities) {
                            Text($0.name ?? "N/A")
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.black)
                }
                .background(RoundedRectangle(cornerRadius: 14).fill(Color(.secondarySystemBackground))
                )

                HStack {
                    VStack(alignment: .leading) {
                        Text("Swing")
                            .font(.title2.bold())
                        Text("Select your swing")
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                    }
                    Spacer()
                    Picker("Swing", selection: $clubManager.swing ) {
                        ForEach(clubManager.swingType, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.black)
                }
                .background(RoundedRectangle(cornerRadius: 14).fill(Color(.secondarySystemBackground))
                )
                
               
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Distance")
                                .font(.title2.bold())
                            Text("Input distance")
                                .foregroundStyle(.secondary)
                                .font(.subheadline)
                        }
                        Spacer()
                        TextField("yds", value: $clubManager.carryDistance, format: .number)
                            .multilineTextAlignment(.trailing)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 70)
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                            .onAppear {
                                UITextField.appearance().clearButtonMode = .whileEditing
                            }
                    }
                
            }
            .padding()
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        isFocused = false
                    } label: {
                        Text("Done")
                    }
                }
            }
        }
    }
}

#Preview {
    AddCarryDistanceScreen()
        .environmentObject(DataController())
        .environmentObject(ClubDetailManager())
}
