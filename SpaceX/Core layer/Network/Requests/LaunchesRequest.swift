//
//  LaunchesRequest.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 12.04.2022.
//

import Foundation

//struct LaunchesReqestModel: Encodable {
//    let query: LaunchRequestQuery
//    let options: [String: String]
//
//    init(rocketId: UUID) {
////        let uuid = UUID(uuidString: )!
//        query = LaunchRequestQuery(rocketId: "5e9d0d95eda69955f709d1eb")
//        options = [:]
////        var query = [String: Any]()
////        query["rocket"] = "5e9d0d95eda69955f709d1eb" //rocketId
////
////        self.query = query
//    }
//}
//
//struct LaunchRequestQuery: Encodable {
//    let rocketId: String
//}

struct LaunchesRequest: Request {
    
    var urlRequest: URLRequest {
        guard let url = URL(string: RequestConstants.apiUrl + "launches") else {
            fatalError("Unable to create url")
        }
  
        
        return URLRequest(url: url)
        
//        let encoder = JSONEncoder()
//        encoder.keyEncodingStrategy = .convertToSnakeCase
//
////        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
////        let queryItem = URLQueryItem(name: "rocket_id", value: "5e9d0d95eda69955f709d1eb")
////        urlComponents?.queryItems = [queryItem]
//
//        let model = LaunchesReqestModel(rocketId: UUID())
//
//        var request = URLRequest(url: url) // urlComponents!.url!)
//        request.httpMethod = "POST"
//        request.httpBody = try? encoder.encode(model)
//
//        return request
    }
}

