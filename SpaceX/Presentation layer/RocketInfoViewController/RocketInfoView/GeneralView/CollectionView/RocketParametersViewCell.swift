//
//  RocketParametersViewCell.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 24.03.2022.
//

import UIKit

private enum Metrics {
    static let collectionViewCellTopVerticalSpacing: CGFloat = 28
    static let collectionViewCellBottomVerticalSpacing: CGFloat = 24
}

final class RocketParametersViewCell: UICollectionViewCell {
    
    /// узнать про reuseIdentifier
    
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
                constant: Metrics.collectionViewCellTopVerticalSpacing),
            valueLabel.bottomAnchor.constraint(equalTo: parameterAndUnitLabel.topAnchor),
            
            parameterAndUnitLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: GlobalMetrics.shortHorizontalSpacing),
            parameterAndUnitLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: GlobalMetrics.shortHorizontalSpacing),
            parameterAndUnitLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: Metrics.collectionViewCellBottomVerticalSpacing)
        ])
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with model: RocketParametersViewCellModel) {
        valueLabel.text = "\(model.value)"
        parameterAndUnitLabel.text = "\(model.parameter), \(model.unit)"
    }
    
    private func configure() {
        valueLabel.font = .systemFont(ofSize: 16, weight: .bold)
        valueLabel.textAlignment = .center
        valueLabel.textColor = GlobalMetrics.Colors.lightTextColor
        
        parameterAndUnitLabel.font = .systemFont(ofSize: 14, weight: .regular)
        parameterAndUnitLabel.textAlignment = .center
        parameterAndUnitLabel.textColor = GlobalMetrics.Colors.unitsTextColor
    }
}
