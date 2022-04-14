//
//  LaunchesRequestService.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 12.04.2022.
//

import Foundation

final class LaunchesRequestService {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
//    func requestRocketInfo(completion: @escaping (Result<[Launch], RequestError>) -> Void) {
//        let dataRequest = LaunchesRequest()
//        
//        networkManager.sendRequest(request: dataRequest) { result in
//            switch result {
//            case .success(let data):
//                break
////                if let launches = self.launchesParser.parseData(data: data) {
////                    completion(.success(launches))
////                }
//            case .failure:
//                completion(.failure(.downloadFail))
//            }
//        }
//    }
}
