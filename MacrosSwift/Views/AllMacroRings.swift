//
//  AllMacroRings.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/5/22.
//

import SwiftUI

struct AllMacroRings: View {    
    @EnvironmentObject var data: MacroData
    @EnvironmentObject var userData: UserData
    @State private var expanded = false
    
    @State private var fatXOffset: CGFloat = 0.0
    @State private var carbYOffset: CGFloat = 0.0
    @State private var proteinXOffset: CGFloat = 0.0
    
    @State private var calorieFrameW: CGFloat = 225
    @State private var proteinFrameW: CGFloat = 175
    @State private var carbFrameW: CGFloat = 125
    @State private var fatFrameW: CGFloat = 75
    
    var body: some View {
        ZStack {
            MacroRing(dataTotal: data.allMacros.calories,
                      macroThreshold: userData.data[0].calThreshold,
                      showDataText: $expanded,
                      ringColor: .orange,
                      lineWidth: 20,
                      fontSize: 20,
                      ringCategory: expanded ? "Calories" : "")
            .frame(width: calorieFrameW)
            .offset(y: expanded ? -100 : 0)
            
            MacroRing(dataTotal: data.allMacros.protein,
                      macroThreshold: userData.data[0].proteinThreshold,
                      showDataText: $expanded,
                      ringColor: .green,
                      lineWidth: 20,
                      fontSize: 20,
                      ringCategory: expanded ? "Protein" : "")
            .frame(width: proteinFrameW)
            .offset(x: proteinXOffset)
            
            MacroRing(dataTotal: data.allMacros.carbs,
                      macroThreshold: userData.data[0].carbsThreshold,
                      showDataText: $expanded,
                      ringColor: .blue,
                      lineWidth: 20,
                      fontSize: 20,
                      ringCategory: expanded ? "Carbs" : "")
            .frame(width: carbFrameW)
            .offset(y: carbYOffset)
            
            MacroRing(dataTotal: data.allMacros.fat,
                      macroThreshold: userData.data[0].fatThreshold,
                      showDataText: $expanded,
                      ringColor: .purple,
                      lineWidth: 20,
                      fontSize: 20,
                      ringCategory: expanded ? "Fat" : "")
            .frame(width: fatFrameW)
            .offset(x: fatXOffset)
            
            Spacer()
        }
        .onAppear {
            userData.getUserData()
            data.getAllMacros()
        }
        .frame(height: expanded ? 385 : 300)
        .onTapGesture {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
                expanded.toggle()
                
                calorieFrameW = expanded ? 150 : 225
                proteinFrameW = expanded ? 100 : 175
                carbFrameW = expanded ? 100 : 125
                fatFrameW = expanded ? 100 : 75
                
                proteinXOffset = expanded ? -125 : 0
                fatXOffset = expanded ? 125 : 0
                carbYOffset = expanded ? 85 : 0
            }
        }
    }
}

struct AllMacroRings_Previews: PreviewProvider {
    static var previews: some View {
        AllMacroRings()
            .environmentObject(MacroData())
            .environmentObject(UserData())
    }
}
