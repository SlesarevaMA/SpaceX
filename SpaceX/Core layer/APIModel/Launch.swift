//
//  Launch.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 16.04.2022.
//

import Foundation

struct Launch: Codable {
    let success: Bool?
    let rocket: String
    let name: String
    let dateUnix: TimeInterval
}
