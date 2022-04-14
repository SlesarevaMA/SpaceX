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
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            setButton.topAnchor.constraint(equalTo: topAnchor),
            setButton.leadingAnchor.constraint(
                greaterThanOrEqualTo: headerLabel.trailingAnchor,
                constant: GlobalMetrics.horizontalSpacing
            ),

            setButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            setButton.widthAnchor.constraint(equalToConstant: 26),
            setButton.heightAnchor.constraint(equalToConstant: 28)
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
        
        
        setButton.setImage(UIImage(named: "settings"), for: .normal)
        setButton.tintColor = GlobalMetrics.Colors.basicColor
    }
}
