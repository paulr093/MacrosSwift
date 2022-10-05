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
    @State private var itemName = ""
    @State private var calories: Double = 0
    @State private var protein: Double = 0
    @State private var carbs: Double = 0
    @State private var fat: Double = 0
    
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                
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
                .frame(maxWidth: .infinity)
            }
            Spacer()
            
        }
        .onTapGesture {
            isPresented.toggle()
        }
        .sheet(isPresented: $isPresented) {
            Form {
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
                    let updated = FoodDataStore.shared.update(id: mealItem.id, itemName: itemName, date: mealItem.date, mealOfDay: mealItem.mealOfDay, calories: calories, protein: protein, carbs: carbs, fat: fat)
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
            itemName = mealItem.itemName
            calories = mealItem.calories
            protein = mealItem.protein
            carbs = mealItem.carbs
            fat = mealItem.fat
        }
    }
    
}

//struct MealRow_Previews: PreviewProvider {
//    static var previews: some View {
//        let ctx = PersistenceController.preview.container.viewContext
//        
//        MealRow(mealItem: Food(context: ctx))
//    }
//}
