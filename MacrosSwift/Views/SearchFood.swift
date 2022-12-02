//
//  SearchFood.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/6/22.
//

import SwiftUI

struct SearchFood: View {
    @EnvironmentObject var data: MacroData
    @State private var text = ""
    
    var body: some View {
        List {
            ForEach(searchResults, id: \.id) { food in
                MealRow(mealItem: food, usedInSearch: true, isUpdating: false)
            }
        }
        .searchable(text: $text, prompt: "Search for past food item")
        .navigationTitle("Food Items")
    }
    
    var searchResults: [FoodItem] {
        if text.isEmpty {
            return data.foodItems
        } else {
            return data.foodItems.filter {$0.itemName.contains(text)}
        }
    }
}

//struct SearchFood_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchFood()
//            .environmentObject(MacroData())
//    }
//}
