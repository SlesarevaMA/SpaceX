//
//  StageInfoView.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 23.03.2022.
//

import UIKit

// повторяющийся код

struct StageInfoViewModel {
    let primaryText: String // не передавать в модели
    let secondaryText: String
    let tertinaryText: String
}

final class StageInfoView: UIView {
    
    private let primaryLabel = UILabel()
    private let secondaryLabel = UILabel()
    private let tertiaryLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(primaryLabel)
        addSubview(secondaryLabel)
        addSubview(tertiaryLabel)
        
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        tertiaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            primaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            primaryLabel.topAnchor.constraint(equalTo: topAnchor),
            primaryLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            primaryLabel.trailingAnchor.constraint(
                equalTo: secondaryLabel.leadingAnchor,
                constant: GlobalMetrics.horizontalSpacing),
            
            secondaryLabel.topAnchor.constraint(equalTo: topAnchor),
            secondaryLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            secondaryLabel.trailingAnchor.constraint(
                equalTo: tertiaryLabel.leadingAnchor,
                constant: GlobalMetrics.shortHorizontalSpacing),
            
            tertiaryLabel.topAnchor.constraint(equalTo: topAnchor),
            tertiaryLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            tertiaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        configLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // повторяющийся код
    
    private func configLabels() {
        primaryLabel.font = .systemFont(ofSize: 16, weight: .regular)
        primaryLabel.textAlignment = .left
        primaryLabel.textColor = GlobalMetricsColors.basicColor
        
        secondaryLabel.font = .systemFont(ofSize: 16, weight: .bold)
        secondaryLabel.textAlignment = .right
        secondaryLabel.textColor = GlobalMetricsColors.basicTextColor
        
        tertiaryLabel.font = .systemFont(ofSize: 16, weight: .bold)
        tertiaryLabel.textAlignment = .center
        tertiaryLabel.textColor = GlobalMetricsColors.unitsTextColor
    }
    
    // повторяющийся код
    
    func configStageInfoView(with model: StageInfoViewModel) {
        primaryLabel.text = model.primaryText
        secondaryLabel.text = model.secondaryText
        tertiaryLabel.text = model.tertinaryText
    }
}
