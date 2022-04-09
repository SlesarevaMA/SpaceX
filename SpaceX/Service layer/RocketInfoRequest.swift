//
//  RocketInfoRequest.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 25.03.2022.
//

import Foundation

final class RocketInfoRequest {
    
    private let spaceRocketsUrlString = "https://api.spacexdata.com/v4/rockets"
    private let launchesUrlString = "https://api.spacexdata.com/v4/launches"
    
    func sendRequest() {
        
        guard let spaceRocketsUrl = URL(string: spaceRocketsUrlString) else {
            print("Invalid Space Rockets Url")
            return
        }
                
        let dataTask = URLSession.shared.dataTask(with: spaceRocketsUrl) { data, response, error in
            if (response as? HTTPURLResponse)?.statusCode == 200, let data = data {
                print(data)
            } else {
                print(RequestError.downloadFail(error))
            }
        }
        
        dataTask.resume()
    }
}
