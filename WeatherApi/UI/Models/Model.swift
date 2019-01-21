//
//  Model.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/16/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class BaseModel {
    
    var country: Country
    var weather: Weather?
    var date: Date?
    
    init(country: Country) {
        self.country = country
        self.weather = nil
    }
}

class Model {

    var values: [BaseModel]
    
    init(values: [BaseModel] = []) {
        self.values = values
    }
}
