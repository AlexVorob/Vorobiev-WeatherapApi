//
//  BaseModel.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/21/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class BaseModel {
    
    var country: Country
    var weather: Weather?
    
    init(country: Country) {
        self.country = country
        self.weather = nil
    }
}
