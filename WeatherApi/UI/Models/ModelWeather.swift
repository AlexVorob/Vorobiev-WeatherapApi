//
//  ModelWeather.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/14/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

struct Weather: Codable {
    
    var main: Main
    
    struct Main: Codable {
        let temp: Double?

        enum CodingKeys: String, CodingKey {
            case temp
        }
    }
}
