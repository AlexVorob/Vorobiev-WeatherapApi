//
//  Temperature.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/31/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

struct Temperature {
    
    var temperature: Double?
    
    public var celsius: String {
        
        return temperature.map { $0.description + UnitTemperature.celsius.symbol } ?? "no data"
    }
    
    public var fahrenheit: String {
        
        return temperature.map { (($0 * 1.8) + 32).description + UnitTemperature.fahrenheit.symbol } ?? "no data"
    }
}
