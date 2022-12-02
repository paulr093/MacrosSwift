//
//  MacroRing.swift
//  MacrosSwift
//
//  Created by Paul Richan on 10/2/22.
//

import SwiftUI

struct MacroRing: View {
    // Data control
    var dataTotal: Double
    var macroThreshold: Int
    @State var ringProgress: Double = 0.0
    @Binding var showDataText: Bool
    
    // Ring styling
    var ringColor: Color
    let lineWidth: CGFloat
    let fontSize: CGFloat
    let ringCategory: String
    let springAnimation: Animation = .spring(response: 0.4, dampingFraction: 0.6)
    
    func isOverThreshold(base: Double, max: Int) -> Bool {
        return Int(base) >= max
    }
    
    var body: some View {
        LazyVStack {
            ZStack {
                Circle()
                    .stroke(.gray, lineWidth: lineWidth)
                    .opacity(0.2)
                
                Circle()
                    .trim(from: 0, to: ringProgress)
                    .stroke(style: StrokeStyle(lineCap: .round))
                    .stroke(isOverThreshold(base: dataTotal, max: macroThreshold) ? .red : ringColor, lineWidth: lineWidth)
                    .rotationEffect(Angle(degrees: -90))
                    .animation(springAnimation, value: ringProgress)
                    .onAppear {
                        ringProgress = Double(dataTotal) / Double(macroThreshold)
                    }
                    .onChange(of: dataTotal) { newData in
                        ringProgress = Double(newData) / Double(macroThreshold)
                    }
                    .onChange(of: macroThreshold) { data in
                        ringProgress = Double(dataTotal) / Double(data)
                    }
                if showDataText {
                    VStack(spacing: 6) {
                        Text("\(String(format: "%.1f", dataTotal))")
                            .foregroundColor(isOverThreshold(base: dataTotal, max: macroThreshold) ? .red : ringColor)
                            .font(.system(size: fontSize))
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        
                        Text(String("\\\(macroThreshold)"))
                            .font(.system(size: fontSize / 1.5))
                            .font(.headline)
                    }
                }
            }
            Text(ringCategory)
                .font(.system(size: fontSize / 1.5))
                .font(.headline)
                .padding()
        }
        .animation(springAnimation, value: ringProgress)
        .foregroundColor(ringColor)
    }
}

struct MacroRing_Previews: PreviewProvider {
    static var previews: some View {
        MacroRing(
            dataTotal: 210,
            macroThreshold: 2000,
            showDataText: .constant(true),
            ringColor: .green,
            lineWidth: 40,
            fontSize: 50,
            ringCategory: "Calories"
        ).frame(width: 350)
    }
}
