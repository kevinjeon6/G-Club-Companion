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
    //Focus is it receiving user input or not. Similar to @State property
    @FocusState private var isFocused: Bool
    @State private var shaftFlex = "Regular"
    
    
    
    //Array of Strings
    let shaftFlexType = ["Regular", "Stiff", "X Stiff", "Senior", "Ladies"]
    
    
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Brand name", text: $brandNameText )
                        .focused($isFocused)
                    
                    Picker("Flex", selection: $shaftFlex) {
                        ForEach(shaftFlexType, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    TextField("Ball brand", text: $ballNameText)
                        .focused($isFocused)
                    
                    TextField("Carry distance (yds)", value: $carryDistance, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    
       
                    Section("Notes"){
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: $noteText)
                                .foregroundColor(.primary)
                                .lineLimit(5)
                                .lineSpacing(5)
                                .frame(height: 280)
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
