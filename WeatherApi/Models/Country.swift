//
//  Country.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/25/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class Country: ObservableObject<DataModels.Event> {
    
    var weather: Weather?

    let name: String
    let capital: String

    init(name: String, capital: String, weather: Weather?) {
        self.name = name
        self.capital = capital
        self.weather = nil
        
        super.init()
    }
}
