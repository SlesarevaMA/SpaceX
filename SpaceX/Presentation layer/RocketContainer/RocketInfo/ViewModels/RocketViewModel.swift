//
//  RocketViewModel.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 11.04.2022.
//

struct RocketViewModel {
    let rocketInfoModel: GeneralInfoViewModel
    let cellViewModels: [RocketCollectionCellViewModel]
    let firstStageModel: StageViewModel
    let secondStageModel: StageViewModel
}
