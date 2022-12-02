//
//  ContentView.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/2/22.
//

import SwiftUI

struct MacroJournal: View {
    @EnvironmentObject var data: MacroData
    @EnvironmentObject var userData: UserData
    @State private var needsUpdating = false
    
    var body: some View {
        VStack {
            AllMacroRings()

            AboveListToolbar()

            MealsList()
        }
        .alert(isPresented: $needsUpdating) {
            Alert(title: Text("Update Your Macros!"), message: Text("Some of your macro goals seem to be set to 0. Please update them by clicking the M at the top."))
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                    EditMacros()
                }
            
            ToolbarItem {
                SearchButton()
            }

            ToolbarItem {
                NavigationLink {
                    AddItem()
                        .environmentObject(data)
                } label: {
                    Image(systemName: "plus")
                }
                }
        }
        .onAppear {
            data.getFoodItems()
            data.getAllMacros()
            userData.getUserData()

            if userData.data[0].calThreshold == 0 ||
                userData.data[0].proteinThreshold == 0 ||
                userData.data[0].carbsThreshold == 0 ||
                userData.data[0].fatThreshold == 0 {
                needsUpdating = true
            }
        }
        .padding()
    }
}

struct MacroJournal_Previews: PreviewProvider {
    static var previews: some View {
        MacroJournal()
            .environmentObject(MacroData())
            .environmentObject(UserData())
    }
}
