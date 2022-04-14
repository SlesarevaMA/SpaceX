//
//  Stage.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 14.04.2022.
//

struct Stage: Codable {
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSec: Int?
}
