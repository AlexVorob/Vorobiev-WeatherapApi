//
//  JSONWeather.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/14/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

public struct JSONWeather: Decodable {
    
    public let dt: Int
    public let main: Main
    public let sys: Sys
    
    public struct Main: Decodable {
        
        public var temp: Double
        
        enum CodingKeys: String, CodingKey {
            case temp = "temp"
        }
    }
    
    public struct Sys: Codable {

        var country: String
    }
}
