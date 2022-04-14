//
//  RocketInfoViewController.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 20.03.2022.
//

import UIKit

private enum Metrics {
    static let verticalSpacing: CGFloat = 48
    static let horizontalSpacing: CGFloat = 32
}

final class RocketInfoViewController: UIViewController {
    
    private let generalView = GeneralInfoView()
    private let firstStageView = StageView()
    private let secondStageView = StageView()
    private let launchesButton = UIButton()
    
    private let parameters = [RocketParametersViewCellModel]()

    private let scrollView = UIScrollView()
    private let rocketInfoService: RocketInfoService
    
    init() {
        let networkManager = NetworkManagerImpl()
        let rocketInfoParser = RocketInfoParser()
        rocketInfoService = RocketInfoServiceImpl(networkManager: networkManager, rocketInfoParser: rocketInfoParser)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generalView.collectionView.dataSource = self
        generalView.collectionView.register(RocketParametersViewCell.self, forCellWithReuseIdentifier: "RocketParametersViewCell")

        addSubViews()
    }
    
    private func addSubViews() {
                
        view.addSubview(scrollView)
        
        scrollView.addSubview(generalView)
        scrollView.addSubview(firstStageView)
        scrollView.addSubview(secondStageView)
        scrollView.addSubview(launchesButton)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        generalView.translatesAutoresizingMaskIntoConstraints = false
        firstStageView.translatesAutoresizingMaskIntoConstraints = false
        secondStageView.translatesAutoresizingMaskIntoConstraints = false
        launchesButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            generalView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: Metrics.horizontalSpacing
            ),
            generalView.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor,
                constant: -Metrics.horizontalSpacing
            ),
            generalView.topAnchor.constraint(
                equalTo: scrollView.topAnchor,
                constant: Metrics.verticalSpacing
            ),
            generalView.bottomAnchor.constraint(
                equalTo: firstStageView.topAnchor,
                constant: -GlobalMetrics.longVerticalSpacing
            ),
            
            firstStageView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: Metrics.horizontalSpacing
            ),
            firstStageView.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor,
                constant: -Metrics.horizontalSpacing
            ),
            firstStageView.bottomAnchor.constraint(
                equalTo: secondStageView.topAnchor,
                constant: -GlobalMetrics.longVerticalSpacing
            ),
            
            secondStageView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: Metrics.horizontalSpacing
            ),
            secondStageView.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor,
                constant: -Metrics.horizontalSpacing
            ),
            secondStageView.bottomAnchor.constraint(
                equalTo: launchesButton.topAnchor,
                constant: -GlobalMetrics.longVerticalSpacing
            ),
            
            launchesButton.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: Metrics.horizontalSpacing
            ),
            launchesButton.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor,
                constant: Metrics.horizontalSpacing
            ),
            launchesButton.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor,
                constant: -GlobalMetrics.verticalSpacing
            )
        ])

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        launchesButton.setTitle("Посмотреть запуски", for: .normal)
        launchesButton.backgroundColor = GlobalMetrics.Colors.buttonBackgroundColor
        launchesButton.setTitleColor(GlobalMetrics.Colors.basicTextColor, for: .normal)
        launchesButton.layer.cornerRadius = 10
        
        firstStageView.stageNumberLabel.text = "ПЕРВАЯ СТУПЕНЬ"
        secondStageView.stageNumberLabel.text = "ВТОРАЯ СТУПЕНЬ"
    }
    
    private func requestRockets() {
        
    }
}

extension RocketInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parameters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RocketParametersViewCell", for: indexPath) as? RocketParametersViewCell  else {
            fatalError("Unable to dequeue RocketParametersViewCell")
        }
        
        let parameter = parameters[indexPath.item]
        
        cell.configureCell(with: parameter)
        
        return cell
    }
}
