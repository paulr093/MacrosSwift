//
//  AboveListToolbar.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/2/22.
//

import SwiftUI

struct AboveListToolbar: View {
    var body: some View {
        HStack {
            DateSelection()
        }
        .padding(.bottom, 2)
        .padding(.top, -20)
    }
}

struct AboveListToolbar_Previews: PreviewProvider {
    static var previews: some View {
        AboveListToolbar()
            .environmentObject(MacroData())
    }
}
