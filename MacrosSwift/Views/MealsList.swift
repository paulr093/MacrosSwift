//
//  MealsList.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/2/22.
//

import SwiftUI

struct MealsList: View {
    @EnvironmentObject var data: MacroData
    
    var body: some View {
        List {
            MealSection(category: "Breakfast")
            MealSection(category: "Lunch")
            MealSection(category: "Dinner")
            MealSection(category: "Snacks")
        }
        .cornerRadius(20)
    }
}

struct MealsList_Previews: PreviewProvider {
    static var previews: some View {
        MealsList()
            .environmentObject(MacroData())
    }
}
