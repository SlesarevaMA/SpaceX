//
//  CoreAssembly.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 17.04.2022.
//

import Foundation

final class CoreAssemlby {
    static let networkManager: NetworkManager = NetworkManagerImpl()
    static let rocketInfoDecoder: JSONDecoder = RocketInfoJSONDecoder()
    static let launchesJSONDecoder: JSONDecoder = LaunchesJSONDecoder()
}
