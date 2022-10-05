//
//  Persistance.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/4/22.
//

import Foundation
import CoreData

class PersistenceController: ObservableObject {
//    static let shared = PersistenceController()
    let container = NSPersistentContainer(name: "FoodItems")
    
//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//        for _ in 0..<1 {
//            let newItem = Food(context: viewContext)
//            newItem.id = UUID()
//            newItem.itemName = "Pancakes"
//            newItem.date = "Oct 4, 2022"
//            newItem.mealOfDay = "Breakfast"
//            newItem.calories = 300
//            newItem.carbs = 10
//            newItem.protein = 12
//            newItem.fat = 10
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()
    
//    let container: NSPersistentContainer
    init() {
            container.loadPersistentStores { description, error in
                if let error = error {
                    print("Failed to load data in DataController \(error.localizedDescription)")
                }
            }
        }
    
//    init(inMemory: Bool = false) {
//        container = NSPersistentContainer(name: "FoodItems")
//        if inMemory {
//            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
//        }
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//
//                /*
//                 Typical reasons for an error here include:
//                 * The parent directory does not exist, cannot be created, or disallows writing.
//                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
//                 * The device is out of space.
//                 * The store could not be migrated to the current model version.
//                 Check the error message to determine what the actual problem was.
//                 */
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        container.viewContext.automaticallyMergesChangesFromParent = true
//    }
    
    func saveData(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved!")
        } catch {
            print("Could not save the data...")
        }
    }
    
    func addFood(item: FoodItem, context: NSManagedObjectContext) {
        let food = Food(context: context)
        food.id = UUID()
        food.date = item.date
        food.itemName = item.itemName
        food.mealOfDay = item.mealOfDay
        food.calories = Double(item.calories)
        food.protein = Double(item.protein)
        food.carbs = Double(item.carbs)
        food.fat = Double(item.fat)
        
        saveData(context: context)
    }
    
    func editFood(food: Food, item: FoodItem, context: NSManagedObjectContext) {
        food.date = item.date
        food.itemName = item.itemName
        food.mealOfDay = item.mealOfDay
        food.calories = item.calories
        food.protein = item.protein
        food.carbs = item.carbs
        food.fat = item.fat
        
        saveData(context: context)
    }
}
