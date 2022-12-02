//
//  UserData.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/2/22.
//

import Foundation

class UserData: ObservableObject {
    @Published var data: [User] = [User(id: 0, calThreshold: 0, proteinThreshold: 0, carbsThreshold: 0, fatThreshold: 0)]
    @Published var isPresentEditMacros = false
    
    func getUserData() {
        data = UserDataStore.shared.getUserData()
    }    
    
//    let sampleData = User(id: 0, calThreshold: 2000, proteinThreshold: 90, carbsThreshold: 220, fatThreshold: 82)
}

struct User: Identifiable {
    var id: Int64
    var calThreshold: Int
    var proteinThreshold: Int
    var carbsThreshold: Int
    var fatThreshold: Int
}
