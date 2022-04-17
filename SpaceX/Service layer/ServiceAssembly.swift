//
//  ServiceAssembly.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 17.04.2022.
//

final class ServiceAsssemlby {
    static let rocketInfoService: RocketInfoService = RocketInfoServiceImpl(
        networkManager: CoreAssemlby.networkManager,
        decoder: CoreAssemlby.rocketInfoDecoder
    )
    
    static let launchesService: LaunchesService = LaunchesServiceImpl(
        networkManager: CoreAssemlby.networkManager,
        decoder: CoreAssemlby.launchesJSONDecoder
    )
}
