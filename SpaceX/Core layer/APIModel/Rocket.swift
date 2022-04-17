//
//  Rocket.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 14.04.2022.
//

import Foundation

struct Rocket: Codable {
    let id: String
    let name: String
    let firstFlight: Date
    let country: String
    let costPerLaunch: Int
    let firstStage: Stage
    let secondStage: Stage
    let height: Length
    let diameter: Length
    let mass: Mass
    let payloadWeights: [PayloadWeight]
    let flickrImages: [URL]
}
