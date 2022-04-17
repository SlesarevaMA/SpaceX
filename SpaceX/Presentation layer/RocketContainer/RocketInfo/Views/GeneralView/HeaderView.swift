//
//  HeaderView.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 23.03.2022.
//

import UIKit

final class HeaderView: UIView {
    
    var didTapSettingsButton: (() -> Void)?
    
    private let headerLabel = UILabel()
    private let settingsButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        
        addSubview(headerLabel)
        addSubview(settingsButton)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            settingsButton.topAnchor.constraint(equalTo: topAnchor),
            settingsButton.leadingAnchor.constraint(
                greaterThanOrEqualTo: headerLabel.trailingAnchor,
                constant: GlobalMetrics.horizontalSpacing
            ),

            settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 26),
            settingsButton.heightAnchor.constraint(equalToConstant: 28)
        ])
    
        configureItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addRocketName(_ name: String) {
        headerLabel.text = name
    }
    
    private func configureItems() {
        headerLabel.text = "Falcon Heavy"
        headerLabel.font = .systemFont(ofSize: 24, weight: .regular)
        headerLabel.textAlignment = .left
        headerLabel.textColor = GlobalMetrics.Colors.basicTextColor
        
        settingsButton.setImage(UIImage(named: "settings"), for: .normal)
        settingsButton.tintColor = GlobalMetrics.Colors.basicColor
    }
    
    @objc private func settingsButtonTapped() {
        didTapSettingsButton?()
    }
}
