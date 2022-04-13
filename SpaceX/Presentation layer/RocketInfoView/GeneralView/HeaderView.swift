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
//            headerLabel.trailingAnchor.constraint(equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: <#T##CGFloat#>)
            
            
            setButton.firstBaselineAnchor.constraint(equalTo: headerLabel.firstBaselineAnchor),
            setButton.topAnchor.constraint(equalTo: topAnchor),
            setButton.bottomAnchor.constraint(equalTo: bottomAnchor),
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
        
        setButton.setImage(UIImage(named: "Image"), for: .normal)
        setButton.backgroundColor = GlobalMetrics.Colors.basicColor
    }
}
