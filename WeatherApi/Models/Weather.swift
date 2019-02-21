//
//  Weather.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/25/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

public class Weather {
    
    private(set) var temperature: Double
    public let id: String
    public let date: Date
    
    public init(date: Date, temperature: Double, id: String) {
        self.temperature = temperature
        self.date = date
        self.id = id
    }
}
