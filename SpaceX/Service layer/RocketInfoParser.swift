//
//  RocketInfoParser.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 27.03.2022.
//

import UIKit

final class RocketInfoParser {
    
    func parseData(data: Data) {
        
        if let jsonObjectList = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
            for json in jsonObjectList {
                
                let rocketName = json["name"] as? String
                
            }
        }
    }
}
