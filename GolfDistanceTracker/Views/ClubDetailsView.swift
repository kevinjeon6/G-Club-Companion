//
//  ClubDetailsView.swift
//  GolfDistanceTracker
//
//  Created by Kevin Mattocks on 8/3/23.
//

import SwiftUI
import TipKit

struct ClubDetailsView: View {
    // MARK: - Properties
    @EnvironmentObject var moc: DataController
    @EnvironmentObject var vm: ClubDetailManager
    @Environment(\.dismiss) var dismiss
    ///Focus is it receiving user input or not. Similar to @State property
    @FocusState private var isFocused: Bool
    @State private var showAlert = false
    
    
    var clubDetails: ClubDetailsEntity?
    private let inputTip = AddClubInfoTip()
    
    var carryDistanceLimit: Bool {
        if vm.carryDistance >= 500 {
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
            return "Save"
        }
    }
    
    
    var doneButtonWithAlert: some View {
        Button {
            isFocused = false
            
            if vm.carryDistance >= 500 {
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
    
    let loftFormatter: NumberFormatter = {
        let loftFormatter = NumberFormatter()
        loftFormatter.numberStyle = .decimal
        loftFormatter.minimumFractionDigits = 1
        loftFormatter.maximumFractionDigits = 1
        return loftFormatter
    }()
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            Form {
                TextField("Brand name", text: $vm.clubBrandName)
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
                    ForEach(vm.flexOption, id: \.self) {
                        Text($0)
                    }
                }
                
                HStack {
                    Text("Loft")
                    Spacer()
                    TextField("0", value: $vm.loftValue, formatter: loftFormatter )
                        .multilineTextAlignment(.trailing)
                        .focused($isFocused)
                        .keyboardType(.decimalPad)
                    Text("°")
                }
                
                TextField("Ball brand", text: $vm.ballBrand)
                    .focused($isFocused)
                    .onAppear{
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
                
                HStack {
                    TextField("Carry distance (yds)", value: $vm.carryDistance, format: .number)
                        .foregroundStyle(vm.carryDistance >= 500 ? Color.red : Color.primary)
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
                    
                    clubDetails?.clubBrandName = vm.clubBrandName
                    clubDetails?.shaftName = vm.shaftName
                    clubDetails?.flex = vm.flex
                    clubDetails?.loftValue = vm.loftValue
                    clubDetails?.ballBrand = vm.ballBrand
                    clubDetails?.carryDistance = Int16(vm.carryDistance)
                    clubDetails?.notes = vm.notes
                   
                    //Save info
                    moc.saveData()
                    //Dismiss after saving
                    dismiss()
 
                } label: {
                    Text(buttonSaveText) ///If carryDistance >=500 is true then text would display Re-enter
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                }
                .listRowBackground(carryDistanceLimit ? Color.red : Color.blue)
                .disabled(carryDistanceLimit)
                
            }
            .onAppear{
                vm.clubBrandName = clubDetails?.clubBrandName ?? ""
                vm.shaftName = clubDetails?.shaftName ?? ""
                vm.carryDistance = Int(clubDetails?.carryDistance ?? 0)
                vm.loftValue = clubDetails?.loftValue ?? 0.0
                vm.flex = clubDetails?.flex ?? ""
                vm.notes = clubDetails?.notes ?? ""
                vm.ballBrand = clubDetails?.ballBrand ?? ""
                
                Task {
                    await AddClubInfoTip.didSelectClub.donate()
                }
            }
            .navigationTitle(clubDetails?.name ?? "N/A")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    doneButtonWithAlert
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    // MARK: - Clear button
                    Button {
                        clubDetails?.clubBrandName = ""
                        clubDetails?.shaftName = ""
                        clubDetails?.flex = "Regular"
                        clubDetails?.loftValue = 0.0
                        clubDetails?.ballBrand = ""
                        clubDetails?.carryDistance = 0
                        clubDetails?.notes = ""
  
                        //Save info
                        moc.saveData()
                       //Dismiss after saving
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
