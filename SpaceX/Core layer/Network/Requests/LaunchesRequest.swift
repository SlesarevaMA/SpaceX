//
//  LaunchesRequest.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 12.04.2022.
//

import Foundation

struct LaunchesRequest: Request {
    
    var urlRequest: URLRequest {
        guard let url = URL(string: RequestConstants.apiUrl + "launches") else {
            fatalError("Unable to create url")
        }
  
        
        return URLRequest(url: url)
    }
}

