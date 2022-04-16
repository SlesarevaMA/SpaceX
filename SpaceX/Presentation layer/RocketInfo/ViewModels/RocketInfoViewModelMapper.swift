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
        formatter.maximumFractionDigits = 1
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        
        return formatter
    }()
    
    func map(model: RocketAPIModel) -> RocketViewModel {
        let firstFlightDate = RocketInfoViewModelMapper.dateFormatter.string(from: model.firstFlight)
        
        
        let launchCostTransform = Float(model.costPerLaunch) / 1000000
    
        let launchCost = RocketInfoViewModelMapper.moneyFormatter.string(from: NSNumber(value: launchCostTransform))
        
        let firstStart = ParameterViewModel(value: firstFlightDate)
        let country = ParameterViewModel(value: model.country)
        
        var launchCostViewModel: ParameterViewModel?
        if let launchCost = launchCost {
            launchCostViewModel = ParameterViewModel(value: "\(launchCost)млн")
        }
        
        let generalInfo = GeneralInfoViewModel(
            rocketName: model.name,
            firstStart: firstStart,
            country: country,
            launchCost: launchCostViewModel
        )
        
        
        
        let heightViewModel = RocketCollectionCellViewModel(parameter: "Высота, ft", value: String(model.height.feet))
        let diameterViewModel = RocketCollectionCellViewModel(parameter: "Диаметр, ft", value: String(model.diameter.feet))
        let massViewModel = RocketCollectionCellViewModel(parameter: "Масса, lb", value: String(model.mass.pounds))
        
        var cellViewModels = [heightViewModel, diameterViewModel, massViewModel]
        
        if let payloadWeight = model.payloadWeights.first(where: { $0.id == "leo" }) {
            let payloadWeightViewModel = RocketCollectionCellViewModel(
                parameter: "Нагрузка, lb",
                value: String(payloadWeight.lb)
            )
            cellViewModels.append(payloadWeightViewModel)
        }
        
        
        let firstStage = mapStage(model: model.firstStage)
        let secondStage = mapStage(model: model.secondStage)
        
        return RocketViewModel(
            rocketInfoModel: generalInfo,
            cellViewModels: cellViewModels,
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
