//
//  RocketInfoViewModelMapper.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 14.04.2022.
//

import Foundation
import UIKit

protocol ViewModelMapping {
    
}

final class ViewModelMapper {
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        return formatter
    }()
    
    private static let moneyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        
        return formatter
    }()
    
    func map(launchModel: Launch) -> LaunchViewModel {
        let dateUnix = Date(timeIntervalSince1970: launchModel.dateUnix)
        let date = ViewModelMapper.dateFormatter.string(from: dateUnix)
        
        return LaunchViewModel(
            launchImage: UIImage(),
            name: launchModel.name,
            date: date
        )
    }
    
    func map(rocketModel: Rocket) -> RocketViewModel {
        let firstFlightDate = ViewModelMapper.dateFormatter.string(from: rocketModel.firstFlight)
        
        let launchCostTransform = Float(rocketModel.costPerLaunch) / 1000000
    
        let launchCost = ViewModelMapper.moneyFormatter.string(from: NSNumber(value: launchCostTransform))
        
        let firstStart = ParameterViewModel(value: firstFlightDate)
        let country = ParameterViewModel(value: rocketModel.country)
        
        var launchCostViewModel: ParameterViewModel?
        if let launchCost = launchCost {
            launchCostViewModel = ParameterViewModel(value: "\(launchCost)млн")
        }
        
        let generalInfo = GeneralInfoViewModel(
            rocketName: rocketModel.name,
            firstStart: firstStart,
            country: country,
            launchCost: launchCostViewModel
        )
        
        let heightViewModel = RocketCollectionCellViewModel(parameter: "Высота, ft", value: String(rocketModel.height.feet))
        let diameterViewModel = RocketCollectionCellViewModel(parameter: "Диаметр, ft", value: String(rocketModel.diameter.feet))
        let massViewModel = RocketCollectionCellViewModel(parameter: "Масса, lb", value: String(rocketModel.mass.pounds))
        
        var cellViewModels = [heightViewModel, diameterViewModel, massViewModel]
        
        if let payloadWeight = rocketModel.payloadWeights.first(where: { $0.id == "leo" }) {
            let payloadWeightViewModel = RocketCollectionCellViewModel(
                parameter: "Нагрузка, lb",
                value: String(payloadWeight.lb)
            )
            cellViewModels.append(payloadWeightViewModel)
        }
        
        
        let firstStage = mapStage(model: rocketModel.firstStage)
        let secondStage = mapStage(model: rocketModel.secondStage)
        
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
