//
//  RocketParametersViewCell.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 24.03.2022.
//

import UIKit

private enum Metrics {
    static let topVerticalSpacing: CGFloat = 28
    static let bottomVerticalSpacing: CGFloat = 24
}

final class RocketParametersViewCell: UICollectionViewCell {
    
    /// узнать про reuseIdentifier
    
    static let reuseIdentifier = "RocketParametersCollectionViewCell"
    
    private let valueLabel = UILabel()
    private var parameterAndUnitLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor(hex: 0x212121)
        contentView.layer.cornerRadius = 32
        
        contentView.addSubview(valueLabel)
        contentView.addSubview(parameterAndUnitLabel)
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        parameterAndUnitLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Metrics.topVerticalSpacing
            ),
            valueLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: GlobalMetrics.shortHorizontalSpacing
            ),
            valueLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -GlobalMetrics.shortHorizontalSpacing
            ),
            
            parameterAndUnitLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor),
            parameterAndUnitLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: GlobalMetrics.shortHorizontalSpacing
            ),
            parameterAndUnitLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -GlobalMetrics.shortHorizontalSpacing
            ),
        ])
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with model: RocketCollectionCellViewModel) {
        valueLabel.text = model.value
        parameterAndUnitLabel.text = model.parameter
    }
    
    private func configure() {
        valueLabel.font = .systemFont(ofSize: 16, weight: .bold)
        valueLabel.textAlignment = .center
        valueLabel.textColor = GlobalMetrics.Colors.lightTextColor
        
        parameterAndUnitLabel.font = .systemFont(ofSize: 13, weight: .regular)
        parameterAndUnitLabel.minimumScaleFactor = 0.8
        parameterAndUnitLabel.textAlignment = .center
        parameterAndUnitLabel.textColor = GlobalMetrics.Colors.unitsTextColor
    }
}
