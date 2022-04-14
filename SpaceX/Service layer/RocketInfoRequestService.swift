//
//  RocketInfoRequestService.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 12.04.2022.
//

import Foundation

protocol RocketInfoService {
    func requestRocketInfo(completion: @escaping (Result<[RocketAPIModel], RequestError>) -> Void)
}

final class RocketInfoServiceImpl: RocketInfoService {
    
    private let networkManager: NetworkManager
    private let decoder: JSONDecoder
    
    init(networkManager: NetworkManager, decoder: JSONDecoder) {
        self.networkManager = networkManager
        self.decoder = decoder
    }
    
    func requestRocketInfo(completion: @escaping (Result<[RocketAPIModel], RequestError>) -> Void) {
        let dataRequest = RocketInfoRequest()
        
        networkManager.sendRequest(request: dataRequest) { result in
            switch result {
            case .success(let data):
                if let rockets = try? self.decoder.decode([RocketAPIModel].self, from: data) {
                    completion(.success(rockets))
                } else {
                    completion(.failure(.parseFail))
                }
            case .failure:
                completion(.failure(.downloadFail))
            }
        }
    }
}
