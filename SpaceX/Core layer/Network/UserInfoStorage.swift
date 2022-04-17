//
//  UserInfoStorage.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 17.04.2022.
//

import Foundation

enum SizeUnit: String {
    case m
    case ft
}

enum WeightUnit: String {
    case kg
    case lb
}

protocol UserInfoStorage {
    func getSizeUnit() -> SizeUnit
    func setSizeUnit(_ sizeUnit: SizeUnit)
    
    func getWeightUnit() -> WeightUnit
    func setWeightUnit(_ weightUnit: WeightUnit)
}

final class UserInfoStargeImpl: UserInfoStorage {
    
    private let storage = UserDefaults.standard
    
    func setSizeUnit(_ sizeUnit: SizeUnit) {
        storage.set(sizeUnit.rawValue, forKey: "SizeUnit")
    }
    
    func getSizeUnit() -> SizeUnit {
        guard
            let unitString = storage.string(forKey: "SizeUnit"),
            let unit = SizeUnit(rawValue: unitString)
        else {
            return .ft
        }
        
        return unit
    }
    
    func setWeightUnit(_ weightUnit: WeightUnit) {
        storage.set(weightUnit.rawValue, forKey: "WeightUnit")
    }
    
    func getWeightUnit() -> WeightUnit {
        guard
            let unitString = storage.string(forKey: "WeightUnit"),
            let unit = WeightUnit(rawValue: unitString)
        else {
            return .lb
        }
        
        return unit
    }
}
