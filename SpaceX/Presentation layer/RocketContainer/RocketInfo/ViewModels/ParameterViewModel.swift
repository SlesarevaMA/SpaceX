//
//  ParameterViewModel.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 14.04.2022.
//

struct ParameterViewModel {
    let value: String
    let unit: String?
    let style: ParameterView.Style
    
    init(value: String, unit: String? = nil, style: ParameterView.Style = .plain) {
        self.value = value
        self.unit = unit
        self.style = style
    }
}
