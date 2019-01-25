//
//  JSONCountry.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/14/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

public struct JSONCountry: Decodable {
    
    public let name: String
    public let capital: String
}
