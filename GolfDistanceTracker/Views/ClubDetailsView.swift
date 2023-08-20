//
//  ClubDetailsView.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 8/3/23.
//

import SwiftUI

struct ClubDetailsView: View {
    // MARK: - Properties
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var moc
    
    var clubDetails: ClubDetailsEntity?

    //Focus is it receiving user input or not. Similar to @State property
    @FocusState private var isFocused: Bool
    @State private var notes = ""
    @State private var clubBrand = ""
    @State private var ballBrand = ""
    @State private var carryDistance = 0
    @State private var shaftName = ""
    @State private var flex = "Regular"
    @State private var loft = "N/A"
    
    
    
    //Array of Strings
    private let shaftFlexType = ["Regular", "Stiff", "X Stiff", "Senior", "Ladies"]
    private let wedgeDegrees = ["N/A", "42°", "44°", "46°", "48°", "50°", "52°", "54°", "56°", "58°", "60°", "62°", "64°"]
    
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            Form {
                TextField("Brand name", text: $clubBrand)
                    .focused($isFocused)
                
                TextField("Shaft", text: $shaftName)
                    .focused($isFocused)
                
                Picker("Flex", selection: $flex) {
                    ForEach(shaftFlexType, id: \.self) {
                        Text($0)
                    }
                }
                
                Picker("Loft", selection: $loft) {
                    ForEach(wedgeDegrees, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Ball brand", text: $ballBrand)
                    .focused($isFocused)
                
                HStack {
                    TextField("Carry distance (yds)", value: $carryDistance, format: .number)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                    Text("yds")
                }
                
                
                Section("Notes"){
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $notes)
                            .foregroundColor(.primary)
                            .lineLimit(5)
                            .lineSpacing(5)
                            .frame(height: 250)
                            .focused($isFocused)
                        
                        if !isFocused && notes.isEmpty {
                            Text("Add notes here")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .headerProminence(.increased)
                
                
            }
            .onAppear{
                clubBrand = clubDetails?.clubBrand ?? ""
                shaftName = clubDetails?.shaftName ?? ""
                carryDistance = Int(clubDetails?.carryDistance ?? 0)
                loft = clubDetails?.loft ?? ""
                flex = clubDetails?.flex ?? ""
                notes = clubDetails?.notes ?? ""
                ballBrand = clubDetails?.ballBrand ?? ""
            }
            .navigationTitle("Club name")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        isFocused = false
                    } label: {
                        Text("Done")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        clubDetails?.clubBrand = clubBrand
                        clubDetails?.shaftName = shaftName
                        clubDetails?.flex = flex
                        clubDetails?.loft = loft
                        clubDetails?.ballBrand = ballBrand
                        clubDetails?.carryDistance = Int16(carryDistance)
                        clubDetails?.notes = notes
                        clubDetails?.id = UUID()
                        
                        //Save info
                        try? moc.save()
                     
                        //Dismiss after saving
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
}

//struct ClubDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ClubDetailsView()
//    }
//}
