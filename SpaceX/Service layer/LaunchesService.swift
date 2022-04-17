//
//  LaunchesService.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 12.04.2022.
//

import Foundation

protocol LaunchesService {
    func requestRocketInfo(completion: @escaping (Result<[Launch], RequestError>) -> Void)
}

final class LaunchesServiceImpl: LaunchesService {
    
    private let networkManager: NetworkManager
    private let decoder: JSONDecoder
    
    init(networkManager: NetworkManager, decoder: JSONDecoder) {
        self.networkManager = networkManager
        self.decoder = decoder
    }
    
    func requestRocketInfo(completion: @escaping (Result<[Launch], RequestError>) -> Void) {
        let dataRequest = LaunchesRequest()
        
        networkManager.sendRequest(request: dataRequest) { result in
            switch result {
            case .success(let data):
                if let launches = try? self.decoder.decode([Launch].self, from: data) {
                    completion(.success(launches))
                } else {
                    completion(.failure(.parseFail))
                }
            case .failure:
                completion(.failure(.downloadFail))
            }
        }
    }
}
