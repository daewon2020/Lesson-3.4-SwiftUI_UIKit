//
//  ContentView.swift
//  Lesson 3.4 SwiftUI_UIKit
//
//  Created by Константин Андреев on 02.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var sliderValue = Int.random(in: 0...100)
    @State private var sliderAlpha: Float = 1
    @State private var isShowAlert = false
    @State private var hiddenNumber = Int.random(in: 0...100)

    var body: some View {
        VStack {
            Text("Подвиньте слайдер, как можно ближе к: \(hiddenNumber)")
            HStack {
                Text("0")
                UIKitSlider(sliderValue: $sliderValue, sliderAlpha: $sliderAlpha, hiddenNumber: $hiddenNumber)
                Text("100")
            }.padding()
            
            Button(action: { isShowAlert.toggle() }) {
                Text("Проверь меня!")
            }.alert("Результат", isPresented: $isShowAlert, actions: {}) {
                Text("\(computeScore())")
            }.padding(.bottom, 20)
            
            Button(
                action: {
                    hiddenNumber = Int.random(in: 0...100)
                    sliderValue = Int.random(in: 0...100)
                }
            ) {
                Text("Начать заново")
            }
        }
    }
    
    private func computeScore() -> Int {
        let difference = abs(hiddenNumber - lround(Double(sliderValue)))
        return 100 - difference
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
