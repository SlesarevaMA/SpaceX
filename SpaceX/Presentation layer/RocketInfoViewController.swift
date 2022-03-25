//
//  RocketInfoViewController.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 20.03.2022.
//

import UIKit

final class RocketInfoViewController: UIViewController {
    
    private let generalView = GeneralView()
    private let firstStageView = StageView()
    private let secondStageView = StageView()
    private let launchesButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(generalView)
        view.addSubview(firstStageView)
        view.addSubview(secondStageView)
        view.addSubview(launchesButton)

        generalView.translatesAutoresizingMaskIntoConstraints = false
        firstStageView.translatesAutoresizingMaskIntoConstraints = false
        secondStageView.translatesAutoresizingMaskIntoConstraints = false
        launchesButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            generalView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: GlobalMetrics.rocketInfoViewControllerHorizontalSpacing),
            generalView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: GlobalMetrics.rocketInfoViewControllerHorizontalSpacing),
            generalView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: GlobalMetrics.rocketInfoViewControllerVerticalSpacing),
            generalView.bottomAnchor.constraint(
                equalTo: firstStageView.topAnchor,
                constant: GlobalMetrics.generalViewLongVerticalSpacing),
            
            firstStageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: GlobalMetrics.rocketInfoViewControllerHorizontalSpacing),
            firstStageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: GlobalMetrics.rocketInfoViewControllerHorizontalSpacing),
            firstStageView.bottomAnchor.constraint(
                equalTo: secondStageView.topAnchor,
                constant: GlobalMetrics.generalViewLongVerticalSpacing),
            
            secondStageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: GlobalMetrics.rocketInfoViewControllerHorizontalSpacing),
            secondStageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: GlobalMetrics.rocketInfoViewControllerHorizontalSpacing),
            secondStageView.bottomAnchor.constraint(
                equalTo: launchesButton.topAnchor,
                constant: GlobalMetrics.generalViewLongVerticalSpacing),
            
            launchesButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: GlobalMetrics.rocketInfoViewControllerHorizontalSpacing),
            launchesButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: GlobalMetrics.rocketInfoViewControllerHorizontalSpacing),
            launchesButton.bottomAnchor.constraint(
                equalTo: launchesButton.topAnchor,
                constant: GlobalMetrics.verticalSpacing)
        ])
    }
    
    private func configlaunchesButton() {
        launchesButton.setTitle("Посмотреть запуски", for: .normal)
        launchesButton.backgroundColor = GlobalMetricsColors.buttonBackgroundColor
        launchesButton.setTitleColor(GlobalMetricsColors.basicTextColor, for: .normal)
        launchesButton.layer.cornerRadius = 10
    }
}
