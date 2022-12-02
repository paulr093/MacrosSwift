//
//  MacrosSwiftApp.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/2/22.
//

import SwiftUI
import CoreData

@main
struct MacrosSwiftApp: App {
    @StateObject var data = MacroData()
    @StateObject var userData = UserData()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MacroJournal()
                    .environmentObject(data)
                    .environmentObject(userData)                
            }
            .onAppear {
                data.getAllMacros()
                data.getFoodItems()
                userData.getUserData()
            }
        }
    }
}
