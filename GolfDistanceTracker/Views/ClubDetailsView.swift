//
//  ClubDetailsView.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 8/3/23.
//

import SwiftUI

struct ClubDetailsView: View {
    // MARK: - Properties
    
    @State private var noteText = ""
    @State private var brandNameText = ""
    @State private var ballNameText = ""
    @State private var carryDistance: Double?
    @State private var shaftType = ""
    //Focus is it receiving user input or not. Similar to @State property
    @FocusState private var isFocused: Bool
    @State private var shaftFlex = "Regular"
    @State private var wedgeSelection = "N/A"
    
    
    
    //Array of Strings
    let shaftFlexType = ["Regular", "Stiff", "X Stiff", "Senior", "Ladies"]
    let wedgeDegrees = ["N/A", "42°", "44°", "46°", "48°", "50°", "52°", "54°", "56°", "58°", "60°", "62°", "64°"]
    
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Brand name", text: $brandNameText )
                        .focused($isFocused)
                    
                    TextField("Shaft", text: $shaftType)
                        .focused($isFocused)
                    
                    Picker("Flex", selection: $shaftFlex) {
                        ForEach(shaftFlexType, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    Picker("Loft", selection: $wedgeSelection) {
                        ForEach(wedgeDegrees, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    TextField("Ball brand", text: $ballNameText)
                        .focused($isFocused)
                    
                    HStack {
                        TextField("Carry distance (yds)", value: $carryDistance, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($isFocused)
                        Text("yds")
                    }

                    
                    Section("Notes"){
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: $noteText)
                                .foregroundColor(.primary)
                                .lineLimit(5)
                                .lineSpacing(5)
                                .frame(height: 250)
                                .focused($isFocused)
                            
                            if !isFocused && noteText.isEmpty {
                                Text("Add notes here")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .headerProminence(.increased)
                
                }
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
                        //Save info
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
}

struct ClubDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ClubDetailsView()
    }
}
