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
    
    private let rocketInfoService: RocketInfoService
    private let viewModelMapper: RocketInfoViewModelMapper
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let generalView = GeneralInfoView()
    private let firstStageView = StageView()
    private let secondStageView = StageView()
    private let launchesButton = UIButton()
    
    private let parameters = [RocketParametersViewCellModel]()
    private var rockets = [RocketViewModel]()
    
    init() {
        let networkManager = NetworkManagerImpl()
        let decoder = SpaceXJSONDecoder()
        rocketInfoService = RocketInfoServiceImpl(networkManager: networkManager, decoder: decoder)
        viewModelMapper = RocketInfoViewModelMapper()
        
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
        requestRockets()
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
            generalView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            generalView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            generalView.topAnchor.constraint(equalTo: contentView.topAnchor),
            generalView.bottomAnchor.constraint(
                equalTo: firstStageView.topAnchor,
                constant: -GlobalMetrics.longVerticalSpacing
            ),
            
            firstStageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            firstStageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            firstStageView.bottomAnchor.constraint(
                equalTo: secondStageView.topAnchor,
                constant: -GlobalMetrics.longVerticalSpacing
            ),
            
            secondStageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            secondStageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            secondStageView.bottomAnchor.constraint(
                equalTo: launchesButton.topAnchor,
                constant: -GlobalMetrics.longVerticalSpacing
            ),
            
            launchesButton.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            launchesButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            launchesButton.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            )
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
        launchesButton.backgroundColor = GlobalMetrics.Colors.buttonBackgroundColor
        launchesButton.setTitleColor(GlobalMetrics.Colors.basicTextColor, for: .normal)
        launchesButton.layer.cornerRadius = 10
        
        firstStageView.stageNumberLabel.text = "ПЕРВАЯ СТУПЕНЬ"
        secondStageView.stageNumberLabel.text = "ВТОРАЯ СТУПЕНЬ"
    }
    
    private func configure(with model: RocketViewModel) {
        generalView.configure(with: model.rocketInfoModel)
        firstStageView.configureModel(model.firstStageModel)
        secondStageView.configureModel(model.secondStageModel)
    }

    private func requestRockets() {
        rocketInfoService.requestRocketInfo { result in
            DispatchQueue.main.async {
                self.processResult(result: result)
            }
        }
    }
    
    private func processResult(result: Result<[RocketAPIModel], RequestError>) {
        switch result {
        case .success(let results):
            rockets = results.map(viewModelMapper.map(model:))
            
            if let firstRocket = rockets.first {
                configure(with: firstRocket)
            }
        case .failure(let error):
            handleError(error)
        }
    }
    
    private func handleError(_ error: RequestError) {
        showAlert(title: "Download fail", message: nil) {
            self.requestRockets()
        }
    }
    
    private func showAlert(title: String, message: String?, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Try again", style: .default) { _ in
            completion()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
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
