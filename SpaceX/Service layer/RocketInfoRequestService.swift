//
//  RocketInfoRequestService.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 12.04.2022.
//

import Foundation

final class RocketInfoRequestService {
    
    private let networkManager: NetworkManager
    private let rocketInfoParser: RocketInfoParser
    
    init(networkManager: NetworkManager, rocketInfoParser: RocketInfoParser) {
        self.networkManager = networkManager
        self.rocketInfoParser = rocketInfoParser
    }
    
    func requestRocketInfo(completion: @escaping (Result<[Rocket], RequestError>) -> Void) {
        
        let dataRequest = RocketInfoRequest()
        
        networkManager.sendRequest(request: dataRequest) { result in
            switch result {
                
            case .success(let data):
                if let rockets = self.rocketInfoParser.parseData(data: data) {
                    completion(.success(rockets))
                }
            case .failure(let error):
                completion(.failure(.downloadFail(error)))
            }
        }
    }
}
