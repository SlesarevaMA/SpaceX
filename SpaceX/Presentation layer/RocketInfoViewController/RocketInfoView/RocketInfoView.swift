//
//  RocketInfoView.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 26.03.2022.
//

import UIKit

private enum Metrics {
    static let rocketInfoViewControllerVerticalSpacing: CGFloat = 48
    static let rocketInfoViewControllerHorizontalSpacing: CGFloat = 32
}

final class RocketInfoView: UIView {
    
    let generalView = GeneralInfoView()
    private let firstStageView = StageView()
    private let secondStageView = StageView()
    private let launchesButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(generalView)
        addSubview(firstStageView)
        addSubview(secondStageView)
        addSubview(launchesButton)
        
        generalView.translatesAutoresizingMaskIntoConstraints = false
        firstStageView.translatesAutoresizingMaskIntoConstraints = false
        secondStageView.translatesAutoresizingMaskIntoConstraints = false
        launchesButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            generalView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Metrics.rocketInfoViewControllerHorizontalSpacing),
            generalView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Metrics.rocketInfoViewControllerHorizontalSpacing),
            generalView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Metrics.rocketInfoViewControllerVerticalSpacing),
            generalView.bottomAnchor.constraint(
                equalTo: firstStageView.topAnchor,
                constant: -GlobalMetrics.longVerticalSpacing),
            
            firstStageView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Metrics.rocketInfoViewControllerHorizontalSpacing),
            firstStageView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Metrics.rocketInfoViewControllerHorizontalSpacing),
            firstStageView.bottomAnchor.constraint(
                equalTo: secondStageView.topAnchor,
                constant: -GlobalMetrics.longVerticalSpacing),
            
            secondStageView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Metrics.rocketInfoViewControllerHorizontalSpacing),
            secondStageView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Metrics.rocketInfoViewControllerHorizontalSpacing),
            secondStageView.bottomAnchor.constraint(
                equalTo: launchesButton.topAnchor,
                constant: -GlobalMetrics.longVerticalSpacing),
            
            launchesButton.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Metrics.rocketInfoViewControllerHorizontalSpacing),
            launchesButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: Metrics.rocketInfoViewControllerHorizontalSpacing),
            launchesButton.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -GlobalMetrics.verticalSpacing)
        ])
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        launchesButton.setTitle("Посмотреть запуски", for: .normal)
        launchesButton.backgroundColor = GlobalMetrics.Colors.buttonBackgroundColor
        launchesButton.setTitleColor(GlobalMetrics.Colors.basicTextColor, for: .normal)
        launchesButton.layer.cornerRadius = 10
        
        firstStageView.stageNumberLabel.text = "ПЕРВАЯ СТУПЕНЬ"
        secondStageView.stageNumberLabel.text = "ВТОРАЯ СТУПЕНЬ"
    }
}
