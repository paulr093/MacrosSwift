//
//  AddItem.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/2/22.
//

import SwiftUI

struct AddItem: View {
    @EnvironmentObject var data: MacroData
    @State private var showSheet = false
    
    @State private var mealOfDay: MealOfDay = .breakfast
    @State private var item: String = ""
    @State private var calories: String = ""
    @State private var protein: String = ""
    @State private var carbs: String = ""
    @State private var fat: String = ""
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    enum MealOfDay: String {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
        case snacks = "Snacks"
    }
    
    var body: some View {
        Button {
            showSheet.toggle()
        } label: {
            Image(systemName: "plus")
                .scaleEffect(1.3)
        }
        .sheet(isPresented: $showSheet) {
            VStack(alignment: .leading) {
                
                Picker("Meal", selection: $mealOfDay) {
                    Text("Breakfast").tag(MealOfDay.breakfast)
                    Text("Lunch").tag(MealOfDay.lunch)
                    Text("Dinner").tag(MealOfDay.dinner)
                    Text("Snacks").tag(MealOfDay.snacks)
                }
                .frame(maxWidth: .infinity)
                .pickerStyle(.segmented)
                
                TextFieldWithTitle(text: $item, label: "Item")
                TextFieldWithTitle(text: $calories, label: "Calories")
                    .keyboardType(.decimalPad)
                TextFieldWithTitle(text: $protein, label: "Protein")
                    .keyboardType(.decimalPad)
                TextFieldWithTitle(text: $carbs, label: "Carbs")
                    .keyboardType(.decimalPad)
                TextFieldWithTitle(text: $fat, label: "Fat")
                    .keyboardType(.decimalPad)
                
                Button {
                    addItem()
                } label: {
                    Text("Add Food Item")
                        .padding()
                }
                .disabled(item.isEmpty || calories.isEmpty || protein.isEmpty || carbs.isEmpty || fat.isEmpty)
                .opacity(item.isEmpty || calories.isEmpty || protein.isEmpty || carbs.isEmpty || fat.isEmpty ? 0.5 : 1)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(10)
                .frame(maxWidth: .infinity, alignment: .center)
                
            }
            .padding()
            .presentationDetents([.medium])
        }
    }
    
    func addItem() {
        let id = FoodDataStore.shared.insert(date: data.globalDate.formatted(date: .abbreviated, time: .omitted), itemName: item, mealOfDay: mealOfDay.rawValue, calories: Double(calories)!, protein: Double(protein)!, carbs: Double(carbs)!, fat: Double(fat)!)
        if id != nil {
            item = ""
            calories = ""
            protein = ""
            carbs = ""
            fat = ""
            showSheet.toggle()
            data.getFoodItems()
        }
    }
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
