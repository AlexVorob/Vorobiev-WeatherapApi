//
//  Weather.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/25/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class Weather: ObservableObject<Weather> {
    
    private(set) var temperature = Temperature()
    let date: Date?
    
    init(json: JSONWeather) {
        self.temperature.temperature = json.main.temp
        self.date = Date(timeIntervalSince1970: TimeInterval(json.dt)) 
    }
}
