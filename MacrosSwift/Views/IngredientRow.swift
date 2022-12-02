//
//  IngredientRow.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/11/22.
//

import SwiftUI

struct IngredientRow: View {
    let ingredient: Ingredient
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(ingredient.name)")
            
            HStack(spacing: 20) {
                HStack {
                    Image(systemName: "c.circle")
                    Text("\(ingredient.calories)")
                }
                
                HStack {
                    Image(systemName: "p.circle")
                    Text("\(ingredient.protein)")
                }
                
                HStack {
                    Image(systemName: "c.square")
                    Text("\(ingredient.carbs)")
                }
                
                HStack {
                    Image(systemName: "f.circle")
                    Text("\(ingredient.fat)")
                }
            }
        }
    }
}

struct IngredientRow_Previews: PreviewProvider {
    static var previews: some View {
        IngredientRow(ingredient: Ingredient(name: "Bacon", calories: "200", carbs: "10", protein: "11", fat: "12"))
    }
}
