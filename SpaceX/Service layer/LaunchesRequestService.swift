//
//  LaunchesRequestService.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 12.04.2022.
//

import Foundation

final class LaunchesRequestService {
    
    private let networkManager: NetworkManager
    private let launchesParser: LaunchesParser
    
    init(networkManager: NetworkManager, launchesParser: LaunchesParser) {
        self.networkManager = networkManager
        self.launchesParser = launchesParser
    }
    
    func requestRocketInfo(completion: @escaping (Result<[Launch], RequestError>) -> Void) {
        
        let dataRequest = LaunchesRequest()
        
        networkManager.sendRequest(request: dataRequest) { result in
            switch result {
                
            case .success(let data):
                if let launches = self.launchesParser.parseData(data: data) {
                    completion(.success(launches))
                }
            case .failure(let error):
                completion(.failure(.downloadFail(error)))
            }
        }
    }
}
