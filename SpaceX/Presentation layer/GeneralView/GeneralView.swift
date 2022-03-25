//
//  GeneralView.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 24.03.2022.
//

import UIKit

struct GeneralViewModel {
    let rocketName: String
    let firstStart: String
    let countryGeneralInfoView: String
    let launchCostGeneralInfoView: String
}

final class GeneralView: UIView {
    
    private let headerView = HeaderView()
    private let rocketParametersCollectionView = RocketParametersCollectionView()
    private let firstStartGeneralInfoView = GeneralInfoView()
    private let countryGeneralInfoView = GeneralInfoView()
    private let launchCostGeneralInfoView = GeneralInfoView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerView)
        addSubview(rocketParametersCollectionView)
        addSubview(firstStartGeneralInfoView)
        addSubview(countryGeneralInfoView)
        addSubview(launchCostGeneralInfoView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        rocketParametersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        firstStartGeneralInfoView.translatesAutoresizingMaskIntoConstraints = false
        countryGeneralInfoView.translatesAutoresizingMaskIntoConstraints = false
        launchCostGeneralInfoView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.bottomAnchor.constraint(
                equalTo: rocketParametersCollectionView.topAnchor,
                constant: GlobalMetrics.generalViewVerticalSpacing
            ),
            
            rocketParametersCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rocketParametersCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rocketParametersCollectionView.bottomAnchor.constraint(
                equalTo: firstStartGeneralInfoView.topAnchor,
                constant: GlobalMetrics.generalViewLongVerticalSpacing
            ),
            
            firstStartGeneralInfoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            firstStartGeneralInfoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            firstStartGeneralInfoView.bottomAnchor.constraint(
                equalTo: countryGeneralInfoView.topAnchor,
                constant: GlobalMetrics.verticalSpacing
            ),
            
            countryGeneralInfoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            countryGeneralInfoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            countryGeneralInfoView.bottomAnchor.constraint(
                equalTo: launchCostGeneralInfoView.topAnchor,
                constant: GlobalMetrics.verticalSpacing
            ),

            launchCostGeneralInfoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            launchCostGeneralInfoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            launchCostGeneralInfoView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configGeneralView() {
        
    }
    
}
