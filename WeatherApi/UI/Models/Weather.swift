//
//  Weather.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/25/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class Weather {
    
    var temperature: Double?
    var date: Date?
    
    init(json: JSONWeather) {
        self.temperature = json.main.temp
        self.date = Date(timeIntervalSince1970: TimeInterval(json.dt)) 
    }
}
