//
//  GeneralInfoView.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 20.03.2022.
//

import UIKit

// повторяющийся код

struct GeneralInfoViewModel {
    let primary: String
    let secondary: String
}

final class GeneralInfoView: UIView {
    
    private let primaryLabel = UILabel()
    private let secondaryLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(primaryLabel)
        addSubview(secondaryLabel)
        
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            primaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            primaryLabel.topAnchor.constraint(equalTo: topAnchor),
            primaryLabel.trailingAnchor.constraint(
                greaterThanOrEqualTo: secondaryLabel.leadingAnchor,
                constant: -GlobalMetrics.horizontalSpacing
            ),
            
            secondaryLabel.topAnchor.constraint(equalTo: topAnchor),
            secondaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            secondaryLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        configureLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // повторяющийся код
    
    func configGeneralInfoView(with model: GeneralInfoViewModel) {
        primaryLabel.text = model.primary
        secondaryLabel.text = model.secondary
    }

    // повторяющийся код
    
    private func configureLabels() {
        primaryLabel.font = .systemFont(ofSize: 16, weight: .regular)
        primaryLabel.textAlignment = .left
        primaryLabel.textColor = GlobalMetricsColors.basicColor
        
        secondaryLabel.font = .systemFont(ofSize: 16, weight: .regular)
        secondaryLabel.textAlignment = .right
        secondaryLabel.textColor = GlobalMetricsColors.basicTextColor
    }
}
