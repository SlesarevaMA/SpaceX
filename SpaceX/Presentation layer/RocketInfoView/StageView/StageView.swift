//
//  StageView.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 22.03.2022.
//

import UIKit

struct StageViewModel {
    let enginesCount: ParameterViewModel
    let fuelQuantity: ParameterViewModel
    let combustionTime: ParameterViewModel
}

final class StageView: UIView {
    
    let stageNumberLabel = UILabel()
    
    private let enginesCountView = ParameterView()
    private let fuelQuantityView = ParameterView()
    private let combustionTimeView = ParameterView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stageNumberLabel)
        addSubview(enginesCountView)
        addSubview(fuelQuantityView)
        addSubview(combustionTimeView)
        
        stageNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        enginesCountView.translatesAutoresizingMaskIntoConstraints = false
        fuelQuantityView.translatesAutoresizingMaskIntoConstraints = false
        combustionTimeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stageNumberLabel.topAnchor.constraint(equalTo: topAnchor),
            stageNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            stageNumberLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            stageNumberLabel.bottomAnchor.constraint(
                equalTo: enginesCountView.topAnchor,
                constant: -GlobalMetrics.verticalSpacing),

            enginesCountView.leadingAnchor.constraint(equalTo: stageNumberLabel.leadingAnchor),
            enginesCountView.trailingAnchor.constraint(equalTo: trailingAnchor),
            enginesCountView.bottomAnchor.constraint(
                equalTo: fuelQuantityView.topAnchor,
                constant: -GlobalMetrics.verticalSpacing),

            fuelQuantityView.leadingAnchor.constraint(equalTo: stageNumberLabel.leadingAnchor),
            fuelQuantityView.trailingAnchor.constraint(equalTo: trailingAnchor),
            fuelQuantityView.bottomAnchor.constraint(
                equalTo: combustionTimeView.topAnchor,
                constant: -GlobalMetrics.verticalSpacing),

            combustionTimeView.leadingAnchor.constraint(equalTo: stageNumberLabel.leadingAnchor),
            combustionTimeView.bottomAnchor.constraint(equalTo: bottomAnchor),
            combustionTimeView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureModel(_ model: StageViewModel) {
        enginesCountView.configureModel(model.enginesCount)
        fuelQuantityView.configureModel(model.fuelQuantity)
        combustionTimeView.configureModel(model.combustionTime)
    }
    
    private func configure() {
        stageNumberLabel.font = .systemFont(ofSize: 18, weight: .bold)
        stageNumberLabel.textAlignment = .left
        stageNumberLabel.textColor = GlobalMetrics.Colors.basicTextColor
        
        enginesCountView.parameterLabel.text = "Количество двигателей"
        fuelQuantityView.parameterLabel.text = "Количество топлива"
        combustionTimeView.parameterLabel.text = "Время сгорания"
    }
}
