//
//  RequestError.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 27.03.2022.
//

enum RequestError: Error {
    case downloadFail(Error?)
    case parseFail(Error?)
}
