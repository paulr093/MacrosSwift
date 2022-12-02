//
//  Search.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/6/22.
//

import SwiftUI

struct SearchButton: View {
    @EnvironmentObject var macroData: MacroData
    @State private var openSearch = true
    @State private var text = ""
    
    var body: some View {
        NavigationStack {
            NavigationLink(destination: SearchFood().environmentObject(macroData)) {
                Image(systemName: "magnifyingglass")
            }
        }
    }
}

struct SearchButton_Previews: PreviewProvider {
    static var previews: some View {
        SearchButton()
    }
}
