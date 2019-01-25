//
//  JSONWeather.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/14/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

public struct JSONWeather: Decodable {
    
    public var dt: Int
    public var main: Main
    
    public struct Main: Decodable {
        
        public var temp: Double?
        
        enum CodingKeys: String, CodingKey {
            case temp = "temp"
        }
    }
}
