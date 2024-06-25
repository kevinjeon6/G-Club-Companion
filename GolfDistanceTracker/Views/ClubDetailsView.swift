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
       
                    clubDetails?.notes = vm.notes
                   
                    //Save info
                    moc.saveData()
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
                vm.clubBrandName = clubDetails?.clubBrandName ?? ""
                vm.shaftName = clubDetails?.shaftName ?? ""
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
                    Button {
                        isFocused = false
                    } label: {
                        Text("Done")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    // MARK: - Clear button
                    Button {
                        clubDetails?.clubBrandName = ""
                        clubDetails?.shaftName = ""
                        clubDetails?.flex = "Regular"
                        clubDetails?.loftValue = 0.0
                        clubDetails?.ballBrand = ""
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
