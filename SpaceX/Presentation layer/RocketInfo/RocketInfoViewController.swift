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
    
    let scrollView = UIScrollView()
    
    private let contentView = UIView()
    
    private let generalView = GeneralInfoView()
    private let firstStageView = StageView()
    private let secondStageView = StageView()
    private let launchesButton = UIButton()
    
    private let parameters = [RocketParametersViewCellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generalView.collectionView.dataSource = self
        generalView.collectionView.register(RocketParametersViewCell.self, forCellWithReuseIdentifier: "RocketParametersViewCell")

        addSubViews()
    }
    
    private func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(generalView)
        contentView.addSubview(firstStageView)
        contentView.addSubview(secondStageView)
        contentView.addSubview(launchesButton)
                
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        generalView.translatesAutoresizingMaskIntoConstraints = false
        firstStageView.translatesAutoresizingMaskIntoConstraints = false
        secondStageView.translatesAutoresizingMaskIntoConstraints = false
        launchesButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            generalView.topAnchor.constraint(equalTo: contentView.topAnchor),
            generalView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            generalView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                        
            firstStageView.topAnchor.constraint(
                equalTo: generalView.bottomAnchor,
                constant: GlobalMetrics.longVerticalSpacing
            ),
            firstStageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.horizontalSpacing
            ),
            firstStageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Metrics.horizontalSpacing
            ),
                        
            secondStageView.topAnchor.constraint(
                equalTo: firstStageView.bottomAnchor,
                constant: GlobalMetrics.longVerticalSpacing
            ),
            secondStageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.horizontalSpacing
            ),
            secondStageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Metrics.horizontalSpacing
            ),
            
            
            launchesButton.topAnchor.constraint(
                equalTo: secondStageView.bottomAnchor,
                constant: GlobalMetrics.longVerticalSpacing
            ),
            launchesButton.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.horizontalSpacing
            ),
            launchesButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Metrics.horizontalSpacing
            ),
            launchesButton.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Metrics.verticalSpacing
            ),
            launchesButton.heightAnchor.constraint(equalToConstant: 56)
        ])

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])
        
        launchesButton.setTitle("Посмотреть запуски", for: .normal)
        launchesButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        launchesButton.backgroundColor = GlobalMetrics.Colors.buttonBackgroundColor
        launchesButton.setTitleColor(GlobalMetrics.Colors.basicTextColor, for: .normal)
        launchesButton.layer.cornerRadius = 10
        
        firstStageView.stageNumberLabel.text = "ПЕРВАЯ СТУПЕНЬ"
        secondStageView.stageNumberLabel.text = "ВТОРАЯ СТУПЕНЬ"
    }
    
    func configure(with model: RocketViewModel) {
        generalView.configure(with: model.rocketInfoModel)
        firstStageView.configureModel(model.firstStageModel)
        secondStageView.configureModel(model.secondStageModel)
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
