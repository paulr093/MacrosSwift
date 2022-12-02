//
//  AddingIngredient.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/11/22.
//

import SwiftUI

struct AddingIngredient: View {
    @Binding var ingredientName: String
    @Binding var ingredientCalories: String
    @Binding var ingredientProtein: String
    @Binding var ingredientCarbs: String
    @Binding var ingredientFat: String
//    let title: String
    
    var body: some View {
        VStack {
            HStack {
                Text("Name: ")
                TextField("Name", text: $ingredientName)
            }
            
            HStack {
                Text("Calories: ")
                TextField("Calories", text: $ingredientCalories)
            }
            
            HStack {
                Text("Protein: ")
                TextField("Protein", text: $ingredientProtein)
            }
            
            HStack {
                Text("Carbs: ")
                TextField("Carbs", text: $ingredientCarbs)
            }
            
            HStack {
                Text("Fat: ")
                TextField("Fat", text: $ingredientFat)
            }
            
        }
    }
}

//struct AddingIngredient_Previews: PreviewProvider {
//    static var previews: some View {
//        AddingIngredient()
//    }
//}
