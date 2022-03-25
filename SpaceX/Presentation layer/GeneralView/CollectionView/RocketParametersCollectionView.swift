//
//  RocketParametersCollectionView.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 24.03.2022.
//

import UIKit

final class RocketParametersCollectionView: UICollectionView {
    
    var cells = [RocketParametersCollectionViewCellModel]()
        
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        register(RocketParametersCollectionViewCell.self,
                 forCellWithReuseIdentifier: RocketParametersCollectionViewCell.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RocketParametersCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: GlobalMetrics.collectionViewCellSide, height: GlobalMetrics.collectionViewCellSide)
    }
}

extension RocketParametersCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: RocketParametersCollectionViewCell.reuseIdentifier,
                                             for: indexPath)  as? RocketParametersCollectionViewCell else {
            fatalError("Unable to dequeue RocketParametersCollectionViewCell")
        }
        
        cell.configCell(with: cells[indexPath.item])
        
        return cell
    }

}


//init() {
//    let layout = UICollectionViewFlowLayout()
//    layout.scrollDirection = .horizontal
//    super.init(frame: .zero, collectionViewLayout: layout)
//}
