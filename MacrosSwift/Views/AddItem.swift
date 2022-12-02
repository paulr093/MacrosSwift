//
//  AddItem.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/2/22.
//

import SwiftUI

struct AddItem: View {
    @EnvironmentObject var data: MacroData
    
    @State private var mealOfDay: MealOfDay = .breakfast
    @State private var mealName: String = ""
    
    @State private var ingredients: [Ingredient] = []
    @State private var ingredientName = ""
    @State private var ingredientCalories = ""
    @State private var ingredientProtein = ""
    @State private var ingredientCarbs = ""
    @State private var ingredientFat = ""
    
//    @State private var calories: String = ""
//    @State private var protein: String = ""
//    @State private var carbs: String = ""
//    @State private var fat: String = ""
    
    @State private var addingIngredient = false
    
    func ingredientFieldsAreEmpty() -> Bool {
        return ingredientCalories.isEmpty || ingredientProtein.isEmpty || ingredientCarbs.isEmpty || ingredientFat.isEmpty || ingredientName.isEmpty
    }
    
    enum MealOfDay: String {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
        case snacks = "Snacks"
    }
    
    var body: some View {
        Form {
            Picker("Meal", selection: $mealOfDay) {
                Text("Breakfast").tag(MealOfDay.breakfast)
                Text("Lunch").tag(MealOfDay.lunch)
                Text("Dinner").tag(MealOfDay.dinner)
                Text("Snacks").tag(MealOfDay.snacks)
            }
            .pickerStyle(.segmented)
            
            Section("Meal Name") {
                TextField("Meal Name", text: $mealName)
                    .textFieldStyle(.plain)
            }
            
            Section("Ingredients") {
                
                if addingIngredient {
                    AddingIngredient(ingredientName: $ingredientName, ingredientCalories: $ingredientCalories, ingredientProtein: $ingredientProtein, ingredientCarbs: $ingredientCarbs, ingredientFat: $ingredientFat)
                } else {
                    ForEach(ingredients) { ingredient in
                        IngredientRow(ingredient: ingredient)
                    }
                    .onDelete { indexSet in
                        deleteIngredient(at: indexSet)
                    }
                }
                
                Button(addingIngredient ? "Submit" : "Add Ingredients") {
                    if addingIngredient && !ingredientFieldsAreEmpty() {
                        ingredients.append(Ingredient(name: ingredientName, calories: ingredientCalories, carbs: ingredientCarbs, protein: ingredientProtein, fat: ingredientFat))
                        ingredientName = ""
                        ingredientCalories = ""
                        ingredientProtein = ""
                        ingredientCarbs = ""
                        ingredientFat = ""
                    }
                    
                    addingIngredient.toggle()
                }
                
                if addingIngredient {
                    Button("Cancel") {
                        addingIngredient.toggle()
                    }
                    .foregroundColor(.red)
                }
                
            }
            
            if !ingredients.isEmpty {
                
                Section("Total Macros") {
                    HStack {
                        HStack {
                            Image(systemName: "c.circle")
                            Text("\(String(format: "%.1f", totalMacros(category: "cals")))")
                        }
                        
                        HStack {
                            Image(systemName: "p.circle")
                            Text("\(String(format: "%.1f", totalMacros(category: "protein")))")
                        }
                        
                        HStack {
                            Image(systemName: "c.square")
                            Text("\(String(format: "%.1f", totalMacros(category: "carbs")))")
                        }
                        
                        HStack {
                            Image(systemName: "f.circle")
                            Text("\(String(format: "%.1f", totalMacros(category: "fat")))")
                        }
                        
                    }
                }
                
            }
            
            
            Button {
                addItem()
            } label: {
                Text("Add Meal Item")
            }
            .disabled(mealName.isEmpty || ingredients.isEmpty)
            .opacity(mealName.isEmpty || ingredients.isEmpty ? 0.5 : 1)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        
    }
    
    func deleteIngredient(at indexSet: IndexSet) {
        let id = indexSet.map { $0 }.first
        if let id = id {
            ingredients.remove(at: id)
        }
    }
    
    func totalMacros(category: String) -> Double {
        var total: Double = 0
        
        switch category {
        case "cals":
            for item in ingredients {
                total += Double(item.calories)!
            }
        case "protein":
            for item in ingredients {
                total += Double(item.protein)!
            }
        case "carbs":
            for item in ingredients {
                total += Double(item.carbs)!
            }
        case "fat":
            for item in ingredients {
                total += Double(item.fat)!
            }
        default:
            total = 0
        }
        
        return total
    }
    
    func addItem() {
        // Add ingredients to new db using the foods row id as the related id
        
        let id = FoodDataStore.shared.insert(date: data.globalDate.formatted(date: .abbreviated, time: .omitted), itemName: mealName, mealOfDay: mealOfDay.rawValue, calories: Double(ingredientCalories)!, protein: Double(ingredientProtein)!, carbs: Double(ingredientCarbs)!, fat: Double(ingredientFat)!)
        if id != nil {
            mealName = ""
            
            data.getFoodItems()
        }
    }
}

struct Ingredient: Identifiable {
    var id = UUID()
    var name: String
    var calories: String
    var carbs: String
    var protein: String
    var fat: String
}

struct TextFieldWithTitle: View {
    @Binding var text: String
    let label: String
    
    var body: some View {
        Text(label)
            .font(.caption)
            .bold()
        TextField(label, text: $text)
            .frame(height: 20)
            .padding(EdgeInsets(top: 7, leading: 6, bottom: 7, trailing: 6))
            .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.925))
            .cornerRadius(5)
    }
}

struct AddItem_Previews: PreviewProvider {
    static var previews: some View {
        AddItem()
            .environmentObject(MacroData())
    }
}
