//
//  RocketInfoParser.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 27.03.2022.
//

import UIKit

protocol Parser {
    associatedtype T
    
    func parseData(data: Data) -> T?
}

final class RocketInfoParser: Parser {
    
    func parseData(data: Data) -> [Rocket]? {
        var rockets = [Rocket]()
        
        guard let jsonObjectList = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            return []
        }
        
        for json in jsonObjectList {
            guard
                let rocketName = json["name"] as? String,
                let firstFlight = json["first_flight"] as? Date,
                let country = json["country"] as? String,
                let costPerLaunch = json["cost_per_launch"] as? Double
            else {
                continue
            }
            
            guard let firstStageInfo = json["first_stage"] as? [String: Any]  else {
                continue
            }
            
            guard
                let firstStageEngines = firstStageInfo["engines"] as? Int,
                let firstStageFuelAmountTons = firstStageInfo["fuel_amount_tons"] as? Double,
                let firstStageBurnTimeSec = firstStageInfo["burn_time_sec"] as? Double
            else {
                continue
            }
         
            guard let secondStageInfo = json["second_stage"] as? [String: Any]  else {
                continue
            }
            
            guard
                let secondStageEngines = secondStageInfo["engines"] as? Int,
                let secondStageFuelAmountTons = secondStageInfo["fuel_amount_tons"] as? Double,
                let secondStageBurnTimeSec = secondStageInfo["burn_time_sec"] as? Double
            else {
                continue
            }
            
            guard
                let height = json["height"] as? [String: Double],
                let diameter = json["diameter"] as? [String :Double],
                let mass = json["country"] as? [String: Double],
                let jsonPayload = json["cost_per_launch"] as? [[String: Any]]
            else {
                continue
            }
            
            var payload = [String:Double]()
            
            for element in jsonPayload where element["id"] as? String == "leo" {
                payload["kg"] = element["kg"] as? Double
                payload["lb"] = element["lb"] as? Double
            }
            
            let rocketInfoModel = RocketInfoModel(
                name: rocketName,
                firstFlight: firstFlight,
                country: country,
                costPerLaunch: costPerLaunch
            )
            
            let collectionParameter = CollectionParameter(
                height: height,
                diameter: diameter,
                mass: mass,
                payload: payload
            )
            
            let firstStage = StageModel(
                engines: firstStageEngines,
                fuelAmountTons: firstStageFuelAmountTons,
                burnTimeSec: firstStageBurnTimeSec
            )
            
            let secondStage = StageModel(
                engines: secondStageEngines,
                fuelAmountTons: secondStageFuelAmountTons,
                burnTimeSec: secondStageBurnTimeSec
            )
            
            let rocket = Rocket(
                rocketInfoModel: rocketInfoModel,
                collectionParameter: collectionParameter,
                firstStageModel: firstStage,
                secondStageModel: secondStage
            )

            rockets.append(rocket)
        }
        
        return rockets
    }
}
