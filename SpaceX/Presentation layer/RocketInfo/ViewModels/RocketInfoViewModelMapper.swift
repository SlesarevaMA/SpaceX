//
//  RocketInfoViewModelMapper.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 14.04.2022.
//

import Foundation

final class RocketInfoViewModelMapper {
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        return formatter
    }()
    
    static let moneyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    func map(model: RocketAPIModel) -> RocketViewModel {
        let firstFlightDate = RocketInfoViewModelMapper.dateFormatter.string(from: model.firstFlight)
        let launchCost = RocketInfoViewModelMapper.moneyFormatter.string(from: NSNumber(integerLiteral: model.costPerLaunch))
        
        let firstStart = ParameterViewModel(value: firstFlightDate)
        let country = ParameterViewModel(value: model.country)
        
        var launchCostViewModel: ParameterViewModel?
        if let launchCost = launchCost {
            launchCostViewModel = ParameterViewModel(value: launchCost)
        }
        
        let generalInfo = GeneralInfoViewModel(
            rocketName: model.name,
            cellViewModels: [],
            firstStart: firstStart,
            country: country,
            launchCost: launchCostViewModel
        )
        
        let firstStage = mapStage(model: model.firstStage)
        let secondStage = mapStage(model: model.secondStage)
        
        return RocketViewModel(
            rocketInfoModel: generalInfo,
            firstStageModel: firstStage,
            secondStageModel: secondStage
        )
    }
    
    private func mapStage(model: Stage) -> StageViewModel {
        var burnTimeViewModel: ParameterViewModel?
        
        if let burnTime = model.burnTimeSec {
            burnTimeViewModel = ParameterViewModel(value: String(burnTime), unit: "sec", style: .unit)
        }
        
        return StageViewModel(
            enginesCount: ParameterViewModel(value: String(model.engines), style: .unit),
            fuelQuantity: ParameterViewModel(value: String(model.fuelAmountTons), unit: "ton", style: .unit),
            burnTime: burnTimeViewModel
        )
    }
    
}
