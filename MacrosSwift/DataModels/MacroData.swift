//
//  MacroData.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/2/22.
//

import Foundation
import SwiftUI
import SQLite

class MacroData: ObservableObject {
    @Published var globalDate: Date = Date.now
    @Published var foodItems: [FoodItem] = []
    
    func getFoodItems() {
        foodItems = FoodDataStore.shared.getAllFoods()
    }
    
    func getItemsByCategory(category: String) -> [FoodItem] {
        return foodItems.filter({$0.date == globalDate.formatted(date: .abbreviated, time: .omitted)}).filter { $0.mealOfDay == category }
    }
    
    func deleteTask(at indexSet: IndexSet, category: String) {
        let id = indexSet.map { self.getItemsByCategory(category: category)[$0].id }.first
        if let id = id {
            let delete = FoodDataStore.shared.delete(id: id)
            if delete {
                getFoodItems()
            }
        }
    }
}

struct AllMacros {
    var calories: Double
    var protein: Double
    var carbs: Double
    var fat: Double
}

struct FoodItem {
    let id: Int64
    var date: String
    var mealOfDay: String
    var itemName: String
    var calories: Double
    var protein: Double
    var carbs: Double
    var fat: Double
}
