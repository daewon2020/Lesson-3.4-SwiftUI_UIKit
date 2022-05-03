//
//  UISlider.swift
//  Lesson 3.4 SwiftUI_UIKit
//
//  Created by Константин Андреев on 03.05.2022.
//

import SwiftUI

struct UIKitSlider: UIViewRepresentable {
    @Binding var sliderValue: Int
    @Binding var sliderAlpha: Float
    @Binding var hiddenNumber: Int

    private let maxSliderValue = 100
    private let minSliderValue = 0
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.thumbTintColor = .red.withAlphaComponent(1)
        slider.minimumValue = Float(minSliderValue)
        slider.maximumValue = Float(maxSliderValue)
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.sliderValueDidChange),
            for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(sliderValue)
        uiView.thumbTintColor = .red.withAlphaComponent(CGFloat(sliderAlpha))
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(sliderValue: $sliderValue, sliderAlpha: $sliderAlpha, hiddenNumber: $hiddenNumber)
    }
}

extension UIKitSlider {
    class Coordinator {
        @Binding var sliderValue: Int
        @Binding var sliderAlpha: Float
        @Binding var hiddenNumber: Int
        
        init(sliderValue: Binding<Int>, sliderAlpha: Binding<Float>, hiddenNumber: Binding<Int>) {
            self._sliderValue = sliderValue
            self._sliderAlpha = sliderAlpha
            self._hiddenNumber = hiddenNumber
        }
        
        @objc func sliderValueDidChange(_ sender: UISlider) {
            sliderValue = Int(sender.value)
            sliderAlpha =  sliderValue <= hiddenNumber
            ? sender.value / Float(hiddenNumber)
            : (100 - sender.value) / sender.value
        }
    }
}
