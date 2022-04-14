//
//  ParameterView.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 20.03.2022.
//

import UIKit

final class ParameterView: UIView {
    
    enum Style {
        case plain
        case unit
    }
    
    let parameterLabel = UILabel()
    
    private let valueLabel = UILabel()
    private let unitLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(parameterLabel)
        addSubview(valueLabel)
        addSubview(unitLabel)
        
        parameterLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        unitLabel.translatesAutoresizingMaskIntoConstraints = false
        
        unitLabel.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        
        NSLayoutConstraint.activate([
            parameterLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            parameterLabel.topAnchor.constraint(equalTo: topAnchor),
            parameterLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            parameterLabel.trailingAnchor.constraint(
                greaterThanOrEqualTo: valueLabel.leadingAnchor,
                constant: -GlobalMetrics.horizontalSpacing
            ),
            
            valueLabel.topAnchor.constraint(equalTo: topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            valueLabel.trailingAnchor.constraint(
                equalTo: unitLabel.leadingAnchor,
                constant: -GlobalMetrics.shortHorizontalSpacing
            ),
            
            unitLabel.topAnchor.constraint(equalTo: topAnchor),
            unitLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            unitLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureModel(_ model: ParameterViewModel) {
        valueLabel.text = model.value
        unitLabel.text = model.unit
        
        switch model.style {
        case .plain:
            valueLabel.font = .systemFont(ofSize: 16, weight: .bold)
        case .unit:
            valueLabel.font = .systemFont(ofSize: 16, weight: .regular)
            
            unitLabel.font = .systemFont(ofSize: 16, weight: .bold)
            unitLabel.textAlignment = .center
            unitLabel.textColor = GlobalMetrics.Colors.unitsTextColor
        }
    }

    private func configure() {
        parameterLabel.font = .systemFont(ofSize: 16, weight: .regular)
        parameterLabel.textAlignment = .left
        parameterLabel.textColor = GlobalMetrics.Colors.basicColor
        
        valueLabel.textAlignment = .right
        valueLabel.textColor = GlobalMetrics.Colors.basicTextColor
    }
}
