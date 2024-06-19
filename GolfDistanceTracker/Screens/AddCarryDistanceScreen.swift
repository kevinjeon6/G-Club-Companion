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
    @State private var showAlert = false
    @State private var date = Date()
    
    var carryDistanceLimit: Bool {
        if clubManager.carryDistance >= 500 {
            return true
            ///True means that the button is disabled and cannot be pressed. The text would be displayed grey until filled based criteria
        }
        return false
        ///False means that the button is enabled and can be pressed
    }
    
    var buttonSaveText: String {
        if carryDistanceLimit {
            return "Re-enter before saving"
        } else {
            return "Enter Shot"
        }
    }
    
    var doneButtonWithAlert: some View {
        Button {
            isFocused = false
            
            if clubManager.carryDistance >= 500 {
                showAlert = true
            }
        } label: {
            Text("Done")
        }
        .alert("Error ⛳️", isPresented: $showAlert) {
            Button("OK") {}
        } message: {
            Text("You cannot input a carry distance of 500 yds or greater")
        }
    }
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Club")
                            .font(.title2.bold())
                        Text("Select your club")
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                    }
                    Spacer()
                    
                    Picker("Club", selection: $moc.driver) {
                        ForEach(moc.savedGolfEntities) { (item: ClubDetailsEntity) in
                            Text(item.name ?? "")
                                .tag(item as ClubDetailsEntity?)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.black)
                }
                
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
                        .frame(width: 80)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                        .onAppear {
                            UITextField.appearance().clearButtonMode = .whileEditing
                        }
                }
                
                
                
                DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                    VStack(alignment: .leading) {
                        Text("Date")
                            .font(.title2.bold())
                        Text("Input date")
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                    }
                }
                .datePickerStyle(.compact)
                
                
                Divider()
                    .padding(.bottom, 10)
                Button{
                    print("Saved distance")
                    moc.addSwing(type: clubManager.swing, yds: clubManager.carryDistance, on: date)           
                } label: {
                    Text(buttonSaveText)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding()
                }
                .background(carryDistanceLimit ? Color.red : Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .disabled(carryDistanceLimit)
                
                Spacer()
                
            }
            .navigationTitle("Add Distance")
            .padding()
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    doneButtonWithAlert
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
