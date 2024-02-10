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
    @EnvironmentObject var vm: ClubDetailManager
    
    
    var clubDetails: ClubDetailsEntity?
    
    //Focus is it receiving user input or not. Similar to @State property
    @FocusState private var isFocused: Bool
    
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            Form {
                TextField("Brand name", text: $vm.clubBrand)
                    .focused($isFocused)
                    .onAppear{
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
                
                TextField("Shaft", text: $vm.shaftName)
                    .focused($isFocused)
                    .onAppear{
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
                
                Picker("Flex", selection: $vm.flex) {
                    ForEach(vm.shaftFlexType, id: \.self) {
                        Text($0)
                    }
                }
                
                Picker("Loft", selection: $vm.loft) {
                    ForEach(vm.wedgeDegrees, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Ball brand", text: $vm.ballBrand)
                    .focused($isFocused)
                    .onAppear{
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
                
                HStack {
                    TextField("Carry distance (yds)", value: $vm.carryDistance, format: .number)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                        .onAppear{
                            UITextField.appearance().clearButtonMode = .whileEditing
                        }
                    Text("yds")
                }
                
                
                Section("Notes"){
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $vm.notes)
                            .foregroundColor(.primary)
                            .lineLimit(5)
                            .lineSpacing(5)
                            .frame(height: 250)
                            .focused($isFocused)
                        
                        if !isFocused && vm.notes.isEmpty {
                            Text("Add notes here")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .headerProminence(.increased)
                
                // MARK: - Save Button
                Button {
                    
                    
                    clubDetails?.clubBrand = vm.clubBrand
                    clubDetails?.shaftName = vm.shaftName
                    clubDetails?.flex = vm.flex
                    clubDetails?.loft = vm.loft
                    clubDetails?.ballBrand = vm.ballBrand
                    clubDetails?.carryDistance = Int16(vm.carryDistance)
                    clubDetails?.notes = vm.notes
                   
                    //Save info
                    
                    vm.saveData(context: moc)
                    //Dismiss after saving
                    dismiss()
 
                } label: {
                    Text("Save")
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                }
                .listRowBackground(Color.blue)
                
            }
            .onAppear{
                vm.clubBrand = clubDetails?.clubBrand ?? ""
                vm.shaftName = clubDetails?.shaftName ?? ""
                vm.carryDistance = Int(clubDetails?.carryDistance ?? 0)
                vm.loft = clubDetails?.loft ?? ""
                vm.flex = clubDetails?.flex ?? ""
                vm.notes = clubDetails?.notes ?? ""
                vm.ballBrand = clubDetails?.ballBrand ?? ""
            }
            .navigationTitle(clubDetails?.name ?? "N/A")
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
                    
                    // MARK: - Clear button
                    Button {
                        clubDetails?.clubBrand = ""
                        clubDetails?.shaftName = ""
                        clubDetails?.flex = "Regular"
                        clubDetails?.loft = "N/A"
                        clubDetails?.ballBrand = ""
                        clubDetails?.carryDistance = 0
                        clubDetails?.notes = ""
                        
                        
                        //Save info
                        vm.saveData(context: moc)
//                        //Dismiss after saving
                        dismiss()
                        

                        
                    } label: {
                        Text("Clear")
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
