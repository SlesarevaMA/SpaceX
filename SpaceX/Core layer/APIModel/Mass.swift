//
//  Mass.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 14.04.2022.
//

struct Mass: Codable {
    let kilograms: Int
    let pounds: Int
    
    enum CodingKeys: String, CodingKey {
        case kilograms = "kg"
        case pounds = "lb"
    }
}
