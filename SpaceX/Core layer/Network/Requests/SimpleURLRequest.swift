//
//  SimpleURLRequest.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 15.04.2022.
//

import Foundation

struct SimpleURLRequest: Request {
    
    var urlRequest: URLRequest {
        return URLRequest(url: url)
    }
    
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
}
