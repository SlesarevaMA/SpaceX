//
//  HeaderView.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 23.03.2022.
//

import UIKit

final class HeaderView: UIView {
    private let headerLabel = UILabel()
    private let setButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerLabel)
        addSubview(setButton)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        setButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            headerLabel.trailingAnchor.constraint(
                greaterThanOrEqualTo: setButton.leadingAnchor,
                constant: GlobalMetrics.horizontalSpacing),
            
            setButton.firstBaselineAnchor.constraint(equalTo: headerLabel.firstBaselineAnchor),
            setButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        configItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addRocketName(_ name: String) {
        headerLabel.text = name
    }
    
    private func configItems() {
        headerLabel.font = .systemFont(ofSize: 24, weight: .regular)
        headerLabel.textAlignment = .left
        headerLabel.textColor = GlobalMetricsColors.basicTextColor
        
        setButton.imageView?.image = UIImage(named: "setImage")
        setButton.backgroundColor = GlobalMetricsColors.basicColor
    }
}
