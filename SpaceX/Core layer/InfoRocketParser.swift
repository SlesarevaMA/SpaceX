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
                
                let companyName = json["companyName"] as? String
                let companySymbol = json["symbol"] as? String
                let price = json["latestPrice"] as? Double
                let priceChange = json["change"] as? Double
                
                
            }
        }
    }
}
