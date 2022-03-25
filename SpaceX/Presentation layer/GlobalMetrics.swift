//
//  GlobalMetrics.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 22.03.2022.
//

import UIKit

// Вынести локальные метрики в Metrics в каждом файле. Оставить только общие.
enum GlobalMetrics {
    static let horizontalSpacing: CGFloat = 19
    static let verticalSpacing: CGFloat = 16
    static let shortHorizontalSpacing: CGFloat = 8
    static let collectionViewCellTopVerticalSpacing: CGFloat = 28
    static let collectionViewCellBottomVerticalSpacing: CGFloat = 24
    static let generalViewVerticalSpacing: CGFloat = 32
    static let generalViewLongVerticalSpacing: CGFloat = 40
    static let collectionViewCellSide: CGFloat = 96
    static let rocketInfoViewControllerVerticalSpacing: CGFloat = 48
    static let rocketInfoViewControllerHorizontalSpacing: CGFloat = 32
}

// Добавить внутрь GlobalMetrics и сделать название просто Colors
enum GlobalMetricsColors {
    static let basicColor = UIColor(hex: 0xCACACA)
    static let basicTextColor = UIColor(hex: 0xF6F6F6)
    static let lightTextColor = UIColor(hex: 0xFFFFFF)
    static let unitsTextColor = UIColor(hex: 0x8E8E8F)
    static let buttonBackgroundColor = UIColor(hex: 0x212121)
}
