//
//  GeneralInfoView.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 24.03.2022.
//

import UIKit

private enum Metrics {
    static let generalViewlSpacing: CGFloat = 32
}

final class GeneralInfoView: UIView {
    
    var didTapSettingsButton: (() -> Void)?
    
    let collectionviewLayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionviewLayout)
    
    private let headerView = HeaderView()
    private let firstStartView = ParameterView()
    private let countryView = ParameterView()
    private let launchCostView = ParameterView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        headerView.didTapSettingsButton = { [weak self] in
            self?.didTapSettingsButton?()
        }
        
        addSubview(headerView)
        addSubview(collectionView)
        addSubview(firstStartView)
        addSubview(countryView)
        addSubview(launchCostView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        firstStartView.translatesAutoresizingMaskIntoConstraints = false
        countryView.translatesAutoresizingMaskIntoConstraints = false
        launchCostView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Metrics.generalViewlSpacing
            ),
            headerView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Metrics.generalViewlSpacing
            ),
                        
            collectionView.topAnchor.constraint(
                equalTo: headerView.bottomAnchor,
                constant: Metrics.generalViewlSpacing
            ),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 96),
            
            firstStartView.topAnchor.constraint(
                equalTo: collectionView.bottomAnchor,
                constant: GlobalMetrics.longVerticalSpacing
            ),
            firstStartView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Metrics.generalViewlSpacing
            ),
            firstStartView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Metrics.generalViewlSpacing
            ),
            
            countryView.topAnchor.constraint(
                equalTo: firstStartView.bottomAnchor,
                constant: GlobalMetrics.verticalSpacing
            ),
            countryView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Metrics.generalViewlSpacing
            ),
            countryView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Metrics.generalViewlSpacing
            ),
           
            launchCostView.topAnchor.constraint(
                equalTo: countryView.bottomAnchor,
                constant: GlobalMetrics.verticalSpacing
            ),
            launchCostView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Metrics.generalViewlSpacing
            ),
            launchCostView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Metrics.generalViewlSpacing
            ),
            launchCostView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        firstStartView.parameterLabel.text = "Первый запуск"
        countryView.parameterLabel.text = "Страна"
        launchCostView.parameterLabel.text = "Стоимость запуска"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: GeneralInfoViewModel) {
        headerView.addRocketName(model.rocketName)
        firstStartView.configureModel(model.firstStart)
        countryView.configureModel(model.country)
        
        if let launchCost = model.launchCost {
            launchCostView.configureModel(launchCost)
        }
    }
}
