//
//  Decoder.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 14.04.2022.
//

import Foundation

final class SpaceXJSONDecoder: JSONDecoder {
    
    override init() {
        super.init()
        
        let dateForamtter = DateFormatter()
        dateForamtter.dateFormat = "yyyy-MM-dd"
        dateDecodingStrategy = .formatted(dateForamtter)
        
        keyDecodingStrategy = .convertFromSnakeCase
    }
}
