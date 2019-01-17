//
//  Model.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/16/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class AbstractModel {
    
    var country: Country
    var weather: Weather?
    
    init(country: Country) {
        self.country = country
        self.weather = nil
    }
}

class Model: ObservableObject<Model.StateWeather> {
    
    public enum StateWeather {
        case weatherChange
        case countryChange
    }
    
    var values: [AbstractModel]
    
    init(values: [AbstractModel] = []) {
        self.values = values
    }
}
