//
//  CollectionViewDelegate.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 27.03.2022.
//

//import UIKit
//
//final class CollectionViewDelegate: AnyObject, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: Metrics.collectionViewCellSide, height: Metrics.collectionViewCellSide)
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return cells.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = dequeueReusableCell(withReuseIdentifier: RocketParametersViewCell.reuseIdentifier,
//                                             for: indexPath)  as? RocketParametersViewCell else {
//            fatalError("Unable to dequeue RocketParametersCollectionViewCell")
//        }
//        
//        cell.configureCell(with: cells[indexPath.item])
//        
//        return cell
//    }
//}
