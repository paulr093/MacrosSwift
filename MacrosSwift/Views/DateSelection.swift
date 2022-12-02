//
//  DateSelection.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/2/22.
//

import SwiftUI

struct DateSelection: View {
    @EnvironmentObject var data: MacroData
    let todaysDate = Date()
    @State private var showButton: Bool = false
    
    func compareDates(chosenDate: Date) {
        if todaysDate.formatted(date: .abbreviated, time: .omitted) != chosenDate.formatted(date: .abbreviated, time: .omitted) {
            showButton = true
        } else {
            showButton = false
        }
    }
    
    var body: some View {
        DatePicker(
            "",
            selection: $data.globalDate,
            displayedComponents: [.date]
        )
        .labelsHidden()
        .onChange(of: data.globalDate) { _ in
            data.getFoodItems()
            data.getAllMacros()
        }
    }
}

struct DateSelection_Previews: PreviewProvider {
    static var previews: some View {
        DateSelection()
            .environmentObject(MacroData())
    }
}
