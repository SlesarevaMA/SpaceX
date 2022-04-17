//
//  ViewModelMapper.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 14.04.2022.
//

import Foundation
import UIKit

protocol ViewModelMapper {
    func map(launchModel: Launch) -> LaunchViewModel
    func map(rocketModel: Rocket) -> RocketViewModel
}

final class ViewModelMapperImpl: ViewModelMapper {
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        return formatter
    }()
    
    private let moneyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        
        return formatter
    }()
    
    private let userInfoStorage: UserInfoStorage
    
    init(userInfoStorage: UserInfoStorage) {
        self.userInfoStorage = userInfoStorage
    }
    
    func map(launchModel: Launch) -> LaunchViewModel {
        let dateUnix = Date(timeIntervalSince1970: launchModel.dateUnix)
        let date = dateFormatter.string(from: dateUnix)
        
        return LaunchViewModel(
            launchImage: UIImage(),
            name: launchModel.name,
            date: date
        )
    }
    
    func map(rocketModel: Rocket) -> RocketViewModel {
        let firstFlightDate = dateFormatter.string(from: rocketModel.firstFlight)
        
        let launchCostMillions = Float(rocketModel.costPerLaunch) / 1000000
        let launchCost = moneyFormatter.string(from: NSNumber(value: launchCostMillions))
        
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
        
        let sizeUnit = userInfoStorage.getSizeUnit()
        let weightUnit = userInfoStorage.getWeightUnit()
        
        let height = sizeUnit == .m ? String(rocketModel.height.meters) : String(rocketModel.height.feet)
        let diameter = sizeUnit == .m ? String(rocketModel.diameter.meters) : String(rocketModel.diameter.feet)
        let mass = weightUnit == .kg ? String(rocketModel.mass.kilograms) : String(rocketModel.mass.pounds)
        
        let heightViewModel = RocketCollectionCellViewModel(
            parameter: "Высота, \(sizeUnit.rawValue)",
            value: height
        )
        let diameterViewModel = RocketCollectionCellViewModel(
            parameter: "Диаметр, \(sizeUnit.rawValue)",
            value: diameter
        )
        let massViewModel = RocketCollectionCellViewModel(
            parameter: "Масса, \(weightUnit.rawValue)",
            value: mass
        )
        
        var cellViewModels = [heightViewModel, diameterViewModel, massViewModel]
        
        if let payloadWeight = rocketModel.payloadWeights.first(where: { $0.id == "leo" }) {
            let payload = weightUnit == .kg ? String(payloadWeight.kg) : String(payloadWeight.lb)
            let payloadWeightViewModel = RocketCollectionCellViewModel(
                parameter: "Нагрузка, \(weightUnit.rawValue)",
                value: payload
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
