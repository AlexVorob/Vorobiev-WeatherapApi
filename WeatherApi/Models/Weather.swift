//
//  Weather.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/25/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

public class Weather {
    
    private(set) var temperature = Temperature()
    
    public let date: Date
    
    public init(date: Date, temperature: Double) {
        self.temperature.temperature = temperature
        self.date = date
    }
}
