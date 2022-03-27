//
//  StageView.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 22.03.2022.
//

import UIKit

struct StageViewModel {
    let stageNumber: String
    let enginesCount: ParameterViewModel
    let fuelQuantity: ParameterViewModel
    let combustionTime: ParameterViewModel
}

final class StageView: UIView {
    
    private let stageNumberLabel = UILabel()
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

            enginesCountView.topAnchor.constraint(
                equalTo: stageNumberLabel.bottomAnchor,
                constant: GlobalMetrics.verticalSpacing),
            enginesCountView.leadingAnchor.constraint(equalTo: stageNumberLabel.leadingAnchor),
            enginesCountView.trailingAnchor.constraint(equalTo: trailingAnchor),

            fuelQuantityView.topAnchor.constraint(
                equalTo: enginesCountView.bottomAnchor,
                constant: GlobalMetrics.verticalSpacing),
            fuelQuantityView.leadingAnchor.constraint(equalTo: stageNumberLabel.leadingAnchor),
            fuelQuantityView.trailingAnchor.constraint(equalTo: trailingAnchor),

            combustionTimeView.topAnchor.constraint(
                equalTo: fuelQuantityView.bottomAnchor,
                constant: GlobalMetrics.verticalSpacing),
            combustionTimeView.leadingAnchor.constraint(equalTo: stageNumberLabel.leadingAnchor),
            combustionTimeView.bottomAnchor.constraint(equalTo: bottomAnchor),
            combustionTimeView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        stageNumberLabel.font = .systemFont(ofSize: 18, weight: .bold)
        stageNumberLabel.textAlignment = .left
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureStageView(with model: StageViewModel) {
        stageNumberLabel.text = model.stageNumber
        enginesCountView.configureModel(model.enginesCount)
        fuelQuantityView.configureModel(model.fuelQuantity)
        combustionTimeView.configureModel(model.combustionTime)
    }
}
