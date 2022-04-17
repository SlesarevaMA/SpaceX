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
    
    var pageNumber = 0
    
    let scrollView = UIScrollView()
    
    private let viewModelMapper: ViewModelMapper
    private weak var presentationAssemlby: PresentationAssemlby?
    
    private let contentView = UIView()
    private let generalView = GeneralInfoView()
    private let firstStageView = StageView()
    private let secondStageView = StageView()
    private let launchesButton = UIButton()
    
    private var parameters = [RocketCollectionCellViewModel]()
    
    private var rocketId: String?
    private var rocketName: String?
    
    init(viewModelMapper: ViewModelMapper, presentationAssemlby: PresentationAssemlby) {
        self.viewModelMapper = viewModelMapper
        self.presentationAssemlby = presentationAssemlby
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionViewLayout = generalView.collectionviewLayout
        collectionViewLayout.itemSize = CGSize(width: 96, height: 96)
        collectionViewLayout.minimumInteritemSpacing = 12
        collectionViewLayout.scrollDirection = .horizontal
        generalView.collectionView.dataSource = self
        generalView.collectionView.register(RocketParametersViewCell.self, forCellWithReuseIdentifier: "RocketParametersViewCell")
        generalView.collectionView.contentInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        generalView.collectionView.showsHorizontalScrollIndicator = false

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
        launchesButton.addTarget(self, action: #selector(showLaunches), for: .touchUpInside)
        
        firstStageView.stageNumberLabel.text = "ПЕРВАЯ СТУПЕНЬ"
        secondStageView.stageNumberLabel.text = "ВТОРАЯ СТУПЕНЬ"
    }
    
    func configure(with model: Rocket) {
        let viewModel = viewModelMapper.map(rocketModel: model)
        
        generalView.configure(with: viewModel.rocketInfoModel)
        firstStageView.configureModel(viewModel.firstStageModel)
        secondStageView.configureModel(viewModel.secondStageModel)
        
        rocketName = model.name
        rocketId = model.id
        
        parameters = viewModel.cellViewModels
        generalView.collectionView.reloadData()
    }
    
    @objc private func showLaunches() {
        guard let launchesViewController = presentationAssemlby?.launchesViewController() else {
            return
        }
        
        launchesViewController.rocketId = rocketId
        launchesViewController.rocketName = rocketName
        
        navigationController?.pushViewController(launchesViewController, animated: true)
    }
}

extension RocketInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parameters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "RocketParametersViewCell",
            for: indexPath
        ) as? RocketParametersViewCell  else {
            fatalError("Unable to dequeue RocketParametersViewCell")
        }
        
        let parameter = parameters[indexPath.item]
        cell.configureCell(with: parameter)
        
        return cell
    }
}
