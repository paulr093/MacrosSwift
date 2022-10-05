//
//  UserData.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/2/22.
//

import Foundation

class UserData: ObservableObject {
//    @Published var data: User
    let sampleData = User(calThreshold: 2000, proteinThreshold: 90, carbsThreshold: 220, fatThreshold: 82)
    
    
}

struct User: Identifiable {
    var id = UUID()
    var calThreshold: Int
    var proteinThreshold: Int
    var carbsThreshold: Int
    var fatThreshold: Int
}
