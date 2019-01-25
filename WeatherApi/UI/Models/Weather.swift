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
    var date: Int?
    
    init(json: JSONWeather) {
        self.temperature = json.main.temp
        self.date = json.dt
    }
}
