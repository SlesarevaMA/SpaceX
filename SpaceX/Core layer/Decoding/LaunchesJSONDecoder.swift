//
//  LaunchesJSONDecoder.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 17.04.2022.
//

import Foundation

final class LaunchesJSONDecoder: JSONDecoder {
    
    override init() {
        super.init()
        
        keyDecodingStrategy = .convertFromSnakeCase
    }
}

