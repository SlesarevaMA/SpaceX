//
//  RocketInfoViewController.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 20.03.2022.
//

import UIKit

final class RocketInfoViewController: UIViewController {
    
    let rocketInfoView = RocketInfoView()
    let parameters = [RocketParametersViewCellModel]()

    private let scrollView = UIScrollView()
    private let rocketInfoRequest = RocketInfoRequest()
    private let rocketInfoParser = RocketInfoParser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.addSubview(rocketInfoView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        rocketInfoView.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            rocketInfoView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            rocketInfoView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            rocketInfoView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            rocketInfoView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
        
//        rocketInfoView.backgroundColor = .cyan
    }    
}

extension RocketInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionView = rocketInfoView.generalView.rocketParametersCollectionView
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RocketParametersCollectionViewCell", for: indexPath) as? RocketParametersViewCell  else {
            fatalError("Unable to dequeue RocketParametersCollectionViewCell")
        }
        
        let parameter = parameters[indexPath.item]
        
        cell.configureCell(with: parameter)
        
        return cell
    }
}
