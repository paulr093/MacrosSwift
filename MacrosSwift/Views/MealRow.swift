//
//  MealRow.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/3/22.
//

import SwiftUI

struct MealRow: View {
    @EnvironmentObject var data: MacroData
    
    var mealItem: FoodItem
    let categoryStyle: Font = .caption
    
    @State private var isPresented = false
    @State private var mealOfDay: MealOfDay = .breakfast
    @State private var itemName = ""
    @State private var calories: Double = 0
    @State private var protein: Double = 0
    @State private var carbs: Double = 0
    @State private var fat: Double = 0
    
    var usedInSearch = false
    var isUpdating = true
    @State private var addedFromSearch = false
    enum MealOfDay: String {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
        case snacks = "Snacks"
    }
    
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                
                if usedInSearch {
                    Text(mealItem.date)
                        .font(.caption)
                        .opacity(0.5)
                }
                
                Text(mealItem.itemName)
                    .font(.headline)
                
                
                HStack {
                    Image(systemName: "c.circle")
                        .font(categoryStyle)
                        .opacity(0.6)
                    Text("\(String(format: "%.1f", calories))")
                        .font(categoryStyle)
                        .foregroundColor(.orange)
                        .bold()
                    
                    Image(systemName: "p.circle")
                        .font(categoryStyle)
                        .opacity(0.6)
                    Text("\(String(format: "%.1f", protein))")
                        .font(categoryStyle)
                        .foregroundColor(.green)
                        .bold()
                    
                    Image(systemName: "c.square")
                        .font(categoryStyle)
                        .opacity(0.6)
                    Text("\(String(format: "%.1f", carbs))")
                        .font(categoryStyle)
                        .foregroundColor(.blue)
                        .bold()
                    
                    Image(systemName: "f.circle")
                        .font(categoryStyle)
                        .opacity(0.6)
                    Text("\(String(format: "%.1f", fat))")
                        .font(categoryStyle)
                        .foregroundColor(.purple)
                        .bold()
                    
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            
        }
        .onTapGesture {
            if isUpdating {
                isPresented.toggle()
            } else {
                let id = FoodDataStore.shared.insert(date: data.globalDate.formatted(date: .abbreviated, time: .omitted), itemName: mealItem.itemName, mealOfDay: mealItem.mealOfDay, calories: mealItem.calories, protein: mealItem.protein, carbs: mealItem.carbs, fat: mealItem.fat)
                
                if id != nil {
                    addedFromSearch = true
                    data.getAllMacros()
                    data.getFoodItems()
                }
            }
        }
        .alert(isPresented: $addedFromSearch) {
            Alert(title: Text("\(mealItem.itemName) was added to \(data.globalDate.formatted(date: .abbreviated, time: .omitted)) \(mealItem.mealOfDay) items!"))
        }
        .sheet(isPresented: $isPresented) {
            Form {
                Picker("Meal", selection: $mealOfDay) {
                    Text("Breakfast").tag(MealOfDay.breakfast)
                    Text("Lunch").tag(MealOfDay.lunch)
                    Text("Dinner").tag(MealOfDay.dinner)
                    Text("Snacks").tag(MealOfDay.snacks)
                }
                .pickerStyle(.segmented)
                
                Section("Item Name") {
                    TextField("Item Name", text: $itemName)
                }
                
                Section("Calories") {
                    TextField("Calories", value: $calories, formatter: Self.formatter)
                        .keyboardType(.decimalPad)
                }
                
                Section("Protein") {
                    TextField("Protein", value: $protein, formatter: Self.formatter)
                        .keyboardType(.decimalPad)
                }
                
                Section("Carbs") {
                    TextField("Carbs", value: $carbs, formatter: Self.formatter)
                        .keyboardType(.decimalPad)
                }
                
                Section("Fat") {
                    TextField("Fat", value: $fat, formatter: Self.formatter)
                        .keyboardType(.decimalPad)
                }
                
                Button("Update") {
                    let updated = FoodDataStore.shared.update(id: mealItem.id, itemName: itemName, date: mealItem.date, mealOfDay: mealOfDay.rawValue, calories: calories, protein: protein, carbs: carbs, fat: fat)
                    if updated {
                        isPresented.toggle()
                    }
                }
            }
            
        }
        .onChange(of: isPresented) { isPresented in
            if !isPresented {
                data.getFoodItems()
            }
        }
        .onAppear {
            switch mealItem.mealOfDay {
            case "Breakfast":
                mealOfDay = .breakfast
            case "Lunch":
                mealOfDay = .lunch
            case "Dinner":
                mealOfDay = .dinner
            case "Snacks":
                mealOfDay = .snacks
            default:
                mealOfDay = .breakfast
            }
            
            itemName = mealItem.itemName
            calories = mealItem.calories
            protein = mealItem.protein
            carbs = mealItem.carbs
            fat = mealItem.fat
        }
    }
    
}

struct MealRow_Previews: PreviewProvider {
    static var previews: some View {
        MealRow(mealItem: FoodItem(id: 0, date: "Oct 3, 2022", mealOfDay: "Breakfast", itemName: "Pancakes", calories: 300, protein: 20, carbs: 10, fat: 12), usedInSearch: true)
    }
}
