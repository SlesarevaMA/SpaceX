//
//  RocketInfoRequest.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 25.03.2022.
//

import Foundation

struct RocketInfoRequest: Request {
    
    var urlRequest: URLRequest {
        guard let url = URL(string: RequestConstants.rocketInfoUrl) else {
            fatalError("Unable to create url")
        }
        
        return URLRequest(url: url)
    }
}
