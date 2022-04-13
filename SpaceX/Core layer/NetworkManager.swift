//
//  NetworkManager.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 12.04.2022.
//

import Foundation

final class NetworkManager {
    func sendRequest(request: Request, completion: @escaping (Result<Data, RequestError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request.urlRequest) { data, response, error in
            if (response as? HTTPURLResponse)?.statusCode == 200, let data = data {
                 completion(.success(data))
             } else {
                 completion(.failure(RequestError.downloadFail))
            }
        }
        
        dataTask.resume()
    }
}
