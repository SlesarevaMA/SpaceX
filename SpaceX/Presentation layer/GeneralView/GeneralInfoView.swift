//
//  GeneralInfoView.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 24.03.2022.
//

import UIKit

struct GeneralInfoViewModel {
    let rocketName: String
    let firstStart: String
    let countryGeneralInfoView: String
    let launchCostGeneralInfoView: String
}

private enum Metrics {
    static let generalViewVerticalSpacing: CGFloat = 32
}

final class GeneralInfoView: UIView {
    
    weak var collectionViewDelegate: UICollectionViewDelegate? {
        get {
            return rocketParametersCollectionView.delegate
        }
        
        set {
            rocketParametersCollectionView.delegate = newValue
        }
    }
    weak var dataSource: UICollectionViewDataSource? {
        get {
            return rocketParametersCollectionView.dataSource
        }
        
        set {
            rocketParametersCollectionView.dataSource = newValue
        }
    }
    
    private let headerView = HeaderView()
    private let rocketParametersCollectionView = UICollectionView()
    private let firstStartView = ParameterView()
    private let countryView = ParameterView()
    private let launchCostView = ParameterView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerView)
        addSubview(rocketParametersCollectionView)
        addSubview(firstStartView)
        addSubview(countryView)
        addSubview(launchCostView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        rocketParametersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        firstStartView.translatesAutoresizingMaskIntoConstraints = false
        countryView.translatesAutoresizingMaskIntoConstraints = false
        launchCostView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.bottomAnchor.constraint(
                equalTo: rocketParametersCollectionView.topAnchor,
                constant: Metrics.generalViewVerticalSpacing
            ),
            
            rocketParametersCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rocketParametersCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rocketParametersCollectionView.bottomAnchor.constraint(
                equalTo: firstStartView.topAnchor,
                constant: GlobalMetrics.longVerticalSpacing
            ),
            
            firstStartView.leadingAnchor.constraint(equalTo: leadingAnchor),
            firstStartView.trailingAnchor.constraint(equalTo: trailingAnchor),
            firstStartView.bottomAnchor.constraint(
                equalTo: countryView.topAnchor,
                constant: GlobalMetrics.verticalSpacing
            ),
            
            countryView.leadingAnchor.constraint(equalTo: leadingAnchor),
            countryView.trailingAnchor.constraint(equalTo: trailingAnchor),
            countryView.bottomAnchor.constraint(
                equalTo: launchCostView.topAnchor,
                constant: GlobalMetrics.verticalSpacing
            ),

            launchCostView.leadingAnchor.constraint(equalTo: leadingAnchor),
            launchCostView.trailingAnchor.constraint(equalTo: trailingAnchor),
            launchCostView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureGeneralView() {
        rocketParametersCollectionView.register(
            RocketParametersViewCell.self,
            forCellWithReuseIdentifier: "RocketParametersViewCell"
        )
    }
    
}
