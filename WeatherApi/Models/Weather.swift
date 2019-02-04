//
//  Weather.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/25/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class Weather {
    
    private(set) var temperature = Temperature()
    let date: Date?
    
    init(date: Date, temperature: Double) {
        self.temperature.temperature = temperature
        self.date = date
    }
}
