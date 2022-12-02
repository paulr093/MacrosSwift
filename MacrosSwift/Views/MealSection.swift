//
//  MealSection.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/4/22.
//

import SwiftUI

struct MealSection: View {
    @EnvironmentObject var data: MacroData
    let category: String
    
    var body: some View {
        Section {
            ForEach (data.getItemsByCategory(category: category), id: \.id) { item in
                MealRow(mealItem: item)
            }
            .onDelete { indexSet in
                data.deleteTask(at: indexSet, category: category)
                data.getFoodItems()
                data.getAllMacros()
            }
        } header: {
            Text(category)
                .padding(.leading, -10)
        }
    }
}

struct MealSection_Previews: PreviewProvider {
    static var previews: some View {
        MealSection(category: "Breakfast")
            .environmentObject(MacroData())
    }
}
