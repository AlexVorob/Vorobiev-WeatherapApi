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
        guard let temp = temperature else { return "" }
        
        return temp.description + UnitTemperature.celsius.symbol
    }
    
    public var fahrenheit: String {
        guard let temp = temperature else { return "" }
        
        let tempFahrenheit = (temp * 1.8) + 32
        
        return tempFahrenheit.description + UnitTemperature.fahrenheit.symbol
    }
}
