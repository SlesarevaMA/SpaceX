//
//  RocketInfoParser.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 27.03.2022.
//

import UIKit

final class RocketInfoParser {
    
    func parseData(data: Data) -> [Rocket]? {
        
        var rockets = [Rocket]()
        
        if let jsonObjectList = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
            for json in jsonObjectList {
                
                guard
                    let rocketName = json["name"] as? String,
                    let firstFlight = json["first_flight"] as? Date,
                    let country = json["country"] as? String,
                    let costPerLaunch = json["cost_per_launch"] as? Double
                else {
                    return nil
                }
                
                guard let firstStageInfo = json["first_stage"] as? [String: Any]  else {
                    return nil
                }
                
                guard
                    let firstStageEngines = firstStageInfo["engines"] as? Int,
                    let firstStageFuelAmountTons = firstStageInfo["fuel_amount_tons"] as? Double,
                    let firstStageBurnTimeSec = firstStageInfo["burn_time_sec"] as? Double
                else {
                    return nil
                }
             
                guard let secondStageInfo = json["second_stage"] as? [String: Any]  else {
                    return nil
                }
                
                guard
                    let secondStageEngines = secondStageInfo["engines"] as? Int,
                    let secondStageFuelAmountTons = secondStageInfo["fuel_amount_tons"] as? Double,
                    let secondStageBurnTimeSec = secondStageInfo["burn_time_sec"] as? Double
                else {
                    return nil
                }
                
                guard
                    let height = json["height"] as? [String:Double],
                    let diameter = json["diameter"] as? [String:Double],
                    let mass = json["country"] as? [String:Double],
                    let jsonPayload = json["cost_per_launch"] as? [[String:Any]]
                else {
                    return nil
                }
                
                var payload = [String:Double]()
                
                for element in jsonPayload {
                    if element["id"] as? String == "leo" {
                        payload["kg"] = element["kg"] as? Double
                        payload["lb"] = element["lb"] as? Double
                    }
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
                
                rockets.append(Rocket(
                    rocketInfoModel: rocketInfoModel,
                    collectionParameter: collectionParameter,
                    firstStageModel: firstStage,
                    secondStageModel: secondStage
                )
                )
            }
        }
        
        return rockets
    }
}
