//
//  ShotHistoryScreen.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 6/6/24.
//

import SwiftUI

struct ShotHistoryScreen: View {
    @EnvironmentObject var moc: DataController
    @EnvironmentObject var clubManager: ClubDetailManager
    
    var selectedSwingType: SwingTypeEntity
    
    @FocusState var isFocused: Bool
    @State private var showAlert = false
    @State private var didEnterShot = false
    
    
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
                        .frame(width: 90)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                        .onAppear {
                            UITextField.appearance().clearButtonMode = .whileEditing
                        }
                    Text("yds")
                }
                
                DatePicker(selection: $clubManager.date, in: ...Date(), displayedComponents: .date) {
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
                    moc.addShotDistance(to: selectedSwingType, distance: clubManager.carryDistance, date: clubManager.date)
                    
                    didEnterShot = true
                    
                    clubManager.carryDistance = 0
                } label: {
                    Text(buttonSaveText)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding()
                }
                .background(carryDistanceLimit ? Color.red : Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .disabled(carryDistanceLimit)
                .alert("Shot Saved", isPresented: $didEnterShot) {
                    Button("OK") {}
                }
                
                Spacer()
              
            }
            .padding()
            .navigationTitle("\(selectedSwingType.swingType ?? "missing")")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    doneButtonWithAlert
                }
            }
            
            List {
                ForEach(selectedSwingType.shotArray, id: \.self) {
                    value in
                    Text("\(value.distance)")
                }
            }
            
            
        }
    }
}


//#Preview {
//    ShotHistoryScreen()
//}



extension SwingTypeEntity {
    ///Referenced HWS Core Data Relationship video
    ///Converting the NSSet to array of ShotEntity
    var shotArray: [ShotEntity] {
        let shot = shots?.array as? [ShotEntity] ?? []
        
        return shot.sorted {$0.dateEntered ?? Date() > $1.dateEntered ?? Date()}
    }
}
