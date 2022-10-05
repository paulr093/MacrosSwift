//
//  ContentView.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/2/22.
//

import SwiftUI

struct MacroJournal: View {
    @EnvironmentObject var data: MacroData
    
    var userData = UserData().sampleData
    struct SmallRing {
        let lineWidth: CGFloat = 10
        let fontSize: CGFloat = 15
    }
    
    private func getAllMacros() -> AllMacros {
        var calories: Double = 0
        var protein: Double = 0
        var carbs: Double = 0
        var fat: Double = 0
        
        for item in data.foodItems.filter({$0.date == data.globalDate.formatted(date: .abbreviated, time: .omitted)}) {
            calories += item.calories
            protein += item.protein
            carbs += item.carbs
            fat += item.fat
        }
        
        return AllMacros(calories: calories, protein: protein, carbs: carbs, fat: fat)
    }
    
    var body: some View {
        VStack {
            MacroRing(
                dataTotal: getAllMacros().calories,
                macroThreshold: userData.calThreshold,
                ringColor: .orange,
                lineWidth: 15,
                fontSize: 20,
                ringCategory: "Calories"
            )
            .frame(width: 100)
            
            HStack {
                MacroRing(
                    dataTotal: getAllMacros().protein,
                    macroThreshold: userData.proteinThreshold,
                    ringColor: .green,
                    lineWidth: SmallRing().lineWidth,
                    fontSize: SmallRing().fontSize,
                    ringCategory: "Protein"
                )
                .frame(width: 70)
                
                Spacer()
                
                MacroRing(
                    dataTotal: getAllMacros().carbs,
                    macroThreshold: userData.carbsThreshold,
                    ringColor: .blue,
                    lineWidth: SmallRing().lineWidth,
                    fontSize: SmallRing().fontSize,
                    ringCategory: "Carbs"
                )
                .frame(width: 70)
                
                Spacer()
                
                MacroRing(
                    dataTotal: getAllMacros().fat,
                    macroThreshold: userData.fatThreshold,
                    ringColor: .purple,
                    lineWidth: SmallRing().lineWidth,
                    fontSize: SmallRing().fontSize,
                    ringCategory: "Fat"
                )
                .frame(width: 70)
                
            }
            .padding()
            
            AboveListToolbar()
            
            MealsList()
            
        }
        .onAppear {
            data.getFoodItems()
        }
        .padding()
    }
}

struct MacroJournal_Previews: PreviewProvider {
    static var previews: some View {
        MacroJournal()
            .environmentObject(MacroData())
    }
}
