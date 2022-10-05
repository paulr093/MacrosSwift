//
//  FoodDataStore.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/5/22.
//

import Foundation
import SQLite

class FoodDataStore {    
    static let DIR_TASK_DB = "Food"
    static let STORE_NAME = "food.sqlite3"
    
    private let foods = Table("foods")
    
    private let id = Expression<Int64>("id")
    private let date = Expression<String>("date")
    private let mealOfDay = Expression<String>("mealOfDay")
    private let itemName = Expression<String>("itemName")
    private let calories = Expression<Double>("calories")
    private let protein = Expression<Double>("protein")
    private let carbs = Expression<Double>("carbs")
    private let fat = Expression<Double>("fat")
    
    static let shared = FoodDataStore()
    
    private var db: Connection? = nil
    
    private init() {
        if let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let dirPath = docDir.appendingPathComponent(Self.DIR_TASK_DB)
            
            do {
                try FileManager.default.createDirectory(atPath: dirPath.path, withIntermediateDirectories: true, attributes: nil)
                let dbPath = dirPath.appendingPathComponent(Self.STORE_NAME).path
                db = try Connection(dbPath)
                createTable()
                print("SQLiteDataStore init successfully at: \(dbPath) ")
            } catch {
                db = nil
                print("SQLiteDataStore init error: \(error)")
            }
        } else {
            db = nil
        }
    }
    
    private func createTable() {
        guard let database = db else {
            return
        }
        do {
            try database.run(foods.create { table in
                table.column(id, primaryKey: .autoincrement)
                table.column(date)
                table.column(mealOfDay)
                table.column(itemName)
                table.column(calories)
                table.column(protein)
                table.column(carbs)
                table.column(fat)
            })
            print("Table Created...")
        } catch {
            print(error)
        }
    }
    
    func insert(date: String, itemName: String, mealOfDay: String, calories: Double, protein: Double, carbs: Double, fat: Double) -> Int64? {
        guard let database = db else { return nil }
        
        let insert = foods.insert(self.date <- MacroData().globalDate.formatted(date: .abbreviated, time: .omitted),
                                  self.mealOfDay <- mealOfDay,
                                  self.itemName <- itemName,
                                  self.calories <- calories,
                                  self.protein <- protein,
                                  self.carbs <- carbs,
                                  self.fat <- fat)
        do {
            let rowID = try database.run(insert)
            return rowID
        } catch {
            print(error)
            return nil
        }
    }
    
    func getAllFoods() -> [FoodItem] {
        var foods: [FoodItem] = []
        guard let database = db else { return [] }
        
        do {
            for item in try database.prepare(self.foods) {
                foods.append(FoodItem(id: item[id], date: item[date], mealOfDay: item[mealOfDay], itemName: item[itemName], calories: item[calories], protein: item[protein], carbs: item[carbs], fat: item[fat]))
            }
        } catch {
            print(error)
        }
        return foods
    }
    
    func update(id: Int64, itemName: String, date: String, mealOfDay: String, calories: Double, protein: Double, carbs: Double, fat: Double) -> Bool {
            guard let database = db else { return false }

            let task = foods.filter(self.id == id)
            do {
                let update = task.update([
                    self.itemName <- itemName,
                    self.date <- date,
                    self.mealOfDay <- mealOfDay,
                    self.calories <- calories,
                    self.protein <- protein,
                    self.carbs <- carbs,
                    self.fat <- fat
                ])
                if try database.run(update) > 0 {
                    return true
                }
            } catch {
                print(error)
            }
            return false
        }
    
    func delete(id: Int64) -> Bool {
        guard let database = db else {
            return false
        }
        do {
            let filter = foods.filter(self.id == id)
            try database.run(filter.delete())
            return true
        } catch {
            print(error)
            return false
        }
    }
}
