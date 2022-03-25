//
//  RocketParametersCollectionViewCell.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 24.03.2022.
//

import UIKit

struct RocketParametersCollectionViewCellModel {
    let value: Double
    let parameter: String
    let unit: String
}

final class RocketParametersCollectionViewCell: UICollectionViewCell {
    
    /// спросить про reuseIdentifier
    
    static let reuseIdentifier = "RocketParametersCollectionViewCell"
    
    private let valueLabel = UILabel()
    private var parameterAndUnitLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(valueLabel)
        addSubview(parameterAndUnitLabel)
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        parameterAndUnitLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            valueLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: GlobalMetrics.shortHorizontalSpacing),
            valueLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: GlobalMetrics.shortHorizontalSpacing),
            valueLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant: GlobalMetrics.collectionViewCellTopVerticalSpacing),
            valueLabel.bottomAnchor.constraint(equalTo: parameterAndUnitLabel.topAnchor),
            
            parameterAndUnitLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: GlobalMetrics.shortHorizontalSpacing),
            parameterAndUnitLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: GlobalMetrics.shortHorizontalSpacing),
            parameterAndUnitLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: GlobalMetrics.collectionViewCellBottomVerticalSpacing)
        ])
        
        configLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(with model: RocketParametersCollectionViewCellModel) {
        valueLabel.text = "\(model.value)"
        parameterAndUnitLabel.text = "\(model.parameter), \(model.unit)"
    }
    
    private func configLabels() {
        valueLabel.font = .systemFont(ofSize: 16, weight: .bold)
        valueLabel.textAlignment = .center
        valueLabel.textColor = GlobalMetricsColors.lightTextColor
        
        parameterAndUnitLabel.font = .systemFont(ofSize: 14, weight: .regular)
        parameterAndUnitLabel.textAlignment = .center
        parameterAndUnitLabel.textColor = GlobalMetricsColors.unitsTextColor
    }
}
