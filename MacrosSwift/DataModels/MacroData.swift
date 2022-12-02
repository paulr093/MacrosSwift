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
    @Published var allMacros: AllMacros = AllMacros(calories: 0, protein: 0, carbs: 0, fat: 0)
    
    func getFoodItems() {
        foodItems = FoodDataStore.shared.getAllFoods()
    }
    
    func getItemsByCategory(category: String) -> [FoodItem] {
        return foodItems.filter{$0.date == globalDate.formatted(date: .abbreviated, time: .omitted)}.filter { $0.mealOfDay == category }
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
    
    func getAllMacros() {
        var calories: Double = 0
        var protein: Double = 0
        var carbs: Double = 0
        var fat: Double = 0
        
        for item in foodItems.filter({$0.date == globalDate.formatted(date: .abbreviated, time: .omitted)}) {
            calories += item.calories
            protein += item.protein
            carbs += item.carbs
            fat += item.fat
        }
        
        allMacros = AllMacros(calories: calories, protein: protein, carbs: carbs, fat: fat)
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
