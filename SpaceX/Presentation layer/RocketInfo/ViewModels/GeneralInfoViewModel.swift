//
//  GeneralInfoViewModel.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 14.04.2022.
//

struct GeneralInfoViewModel {
    let rocketName: String
    let cellViewModels: [RocketCollectionCellViewModel]
    let firstStart: ParameterViewModel
    let country: ParameterViewModel
    let launchCost: ParameterViewModel?
}
