//
//  EditMacros.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/5/22.
//

import SwiftUI

struct EditMacros: View {
    @State private var isPresented = false
    @EnvironmentObject var userData: UserData
    
    @State private var calThreshold = 0
    @State private var proteinThreshold = 0
    @State private var carbsThreshold = 0
    @State private var fatThreshold = 0
    
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }()
    
    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            Image(systemName: "m.circle")
        }
        .onChange(of: isPresented) { newValue in
            if !newValue {
                userData.getUserData()
            }
        }
        .onAppear {
            calThreshold = userData.data[0].calThreshold
            proteinThreshold = userData.data[0].proteinThreshold
            carbsThreshold = userData.data[0].carbsThreshold
            fatThreshold = userData.data[0].fatThreshold
            isPresented = userData.isPresentEditMacros
        }
        .sheet(isPresented: $isPresented) {
            Form {
                Section("Your Macro Goals") {
                    HStack {
                        Text("Calories: ")
                        TextField("Calorie Goal", value: $calThreshold, formatter: EditMacros.formatter)
                            .keyboardType(.numberPad)
                    }
                    
                    HStack {
                        Text("Protein: ")
                        TextField("Protein Goal", value: $proteinThreshold, formatter: EditMacros.formatter)
                            .keyboardType(.numberPad)
                    }
                    
                    HStack {
                        Text("Carbs: ")
                        TextField("Carbs Goal", value: $carbsThreshold, formatter: EditMacros.formatter)
                            .keyboardType(.numberPad)
                    }
                    
                    HStack {
                        Text("Fat: ")
                        TextField("Fat Goal", value: $fatThreshold, formatter: EditMacros.formatter)
                            .keyboardType(.numberPad)
                    }
                }
                
                Button("Update") {
                    
                    let updated = UserDataStore.shared.update(id: userData.data[0].id, calThreshold: calThreshold, proteinThreshold: proteinThreshold, carbsThreshold: carbsThreshold, fatThreshold: fatThreshold)
                    
                    if updated {
                        isPresented.toggle()
                    }
                    
                }
                .presentationDetents([.medium])
            }
        }
        
        
    }
}

struct EditMacros_Previews: PreviewProvider {
    static var previews: some View {
        EditMacros()
            .environmentObject(UserData())
    }
}
