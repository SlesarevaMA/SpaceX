//
//  RocketInfoService.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 12.04.2022.
//

import UIKit

protocol RocketInfoService {
    func requestRocketInfo(completion: @escaping (Result<[Rocket], RequestError>) -> Void)
    func requestImage(at url: URL, completion: @escaping (UIImage?) -> Void)
}

final class RocketInfoServiceImpl: RocketInfoService {
    
    private let networkManager: NetworkManager
    private let decoder: JSONDecoder
    
    init(networkManager: NetworkManager, decoder: JSONDecoder) {
        self.networkManager = networkManager
        self.decoder = decoder
    }
    
    func requestRocketInfo(completion: @escaping (Result<[Rocket], RequestError>) -> Void) {
        let dataRequest = RocketInfoRequest()
        
        networkManager.sendRequest(request: dataRequest) { result in
            switch result {
            case .success(let data):                
                if let rockets = try? self.decoder.decode([Rocket].self, from: data) {
                    completion(.success(rockets))
                } else {
                    completion(.failure(.parseFail))
                }
            case .failure:
                completion(.failure(.downloadFail))
            }
        }
    }
    
    func requestImage(at url: URL, completion: @escaping (UIImage?) -> Void) {
        let request = SimpleURLRequest(url: url)
        
        networkManager.sendRequest(request: request) { result in
            if case let .success(imageData) = result {
                let image = UIImage(data: imageData)
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
}
